#!/bin/sh
# FortiGate deploy hook for acme.sh
# acme.sh deploy hook: FortiGate certificate swap/bind
# Uses forti_cert_swap.py (v1.8.x+) and prefers a YAML config.
# Optional persistent config: $HOME/.acme.sh/fortigate.env
# Copyright (c) 2025 CyB0rgg @ Kiroshi.Group
# Co-authored by Jarvis @ Kiroshi.Group
# License: MIT


# ---- Optional persistent env file (won't be touched by acme.sh) ----
: "${FORTI_ENV:=$HOME/.acme.sh/fortigate.env}"
if [ -f "$FORTI_ENV" ]; then
  # shellcheck disable=SC1090
  . "$FORTI_ENV"
fi
# --------------------------------------------------------------------

# Allow overriding the binary path if needed
: "${FORTI_BIN:=forti_cert_swap.py}"

# Minimal echo helpers (acme.sh defines _info/_err; fall back if missing)
say_info() {
  if command -v _info >/dev/null 2>&1; then _info "$1"; else printf '%s\n' "$1"; fi
}
say_err() {
  if command -v _err >/dev/null 2>&1; then _err "$1"; else printf 'ERROR: %s\n' "$1" >&2; fi
}

# fortigate_deploy <domain> <keyfile> <certfile> <cafile> <fullchain> <reloadcmd>
fortigate_deploy() {
  _domain="$1"
  _keyfile="$2"
  _certfile="$3"
  _cafile="$4"
  _fullchain="$5"
  _reloadcmd="$6"

  say_info "FortiGate deploy for $_domain"

  # Sanity checks
  if ! command -v "$FORTI_BIN" >/dev/null 2>&1; then
    say_err "Can't find '$FORTI_BIN' in PATH. Set FORTI_BIN to the full path or place it in PATH."
    return 1
  fi

  # Prefer YAML config but allow running without it
  _cmd="$FORTI_BIN"
  if [ -n "$FORTI_CONFIG" ] && [ -f "$FORTI_CONFIG" ]; then
    _cmd="$_cmd -C \"$FORTI_CONFIG\""
  else
    say_info "[warn] FORTI_CONFIG not set or file missing; proceeding with CLI args only."
  fi

  # Always use the freshly-issued material from acme.sh
  # We pass fullchain (leaf+intermediates) and the private key
  if [ -n "$_fullchain" ] && [ -f "$_fullchain" ]; then
    _cmd="$_cmd --cert \"$_fullchain\""
  else
    # fallback to certfile if fullchain is not provided
    if [ -n "$_certfile" ] && [ -f "$_certfile" ]; then
      _cmd="$_cmd --cert \"$_certfile\""
    else
      say_err "Neither fullchain nor cert file is available from acme.sh env."
      return 1
    fi
  fi

  if [ -n "$_keyfile" ] && [ -f "$_keyfile" ]; then
    _cmd="$_cmd --key \"$_keyfile\""
  else
    say_err "Key file not found: $_keyfile"
    return 1
  fi

  # Optional logging
  if [ -n "$FORTI_LOG" ]; then
    _cmd="$_cmd --log \"${FORTI_LOG}\""
  fi
  if [ -n "$FORTI_LOG_LEVEL" ]; then
    _cmd="$_cmd --log-level \"${FORTI_LOG_LEVEL}\""
  fi

  # Optional extras passthrough (e.g., --insecure or --prune) if user wants
  if [ -n "$FORTI_EXTRA" ]; then
    _cmd="$_cmd ${FORTI_EXTRA}"
  fi

  say_info "Command: $(printf "%s" "$_cmd" | sed 's/ --token [^ ]*/ --token *******/g')"
  # shellcheck disable=SC2086
  eval $_cmd
  _rc=$?

  if [ $_rc -ne 0 ]; then
    say_err "FortiGate deploy failed (rc=$_rc)."
    return $_rc
  fi

  say_info "FortiGate deploy finished"
  return 0
}