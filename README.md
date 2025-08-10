# acme-deploy-fortigate

FortiGate deploy hook for [acme.sh](https://github.com/acmesh-official/acme.sh) that swaps/binds a freshly renewed TLS certificate onto a FortiGate device.

> **Prerequisite**: Requires [fortigate-cert-swap](https://github.com/CyB0rgg/fortigate-cert-swap) v1.8.0+ installed and configured.

## Usage

Preferred approach: use a `fortigate.yaml` configuration file for settings, then call the deploy hook. CLI options will override config file values.

Example:
```bash
acme.sh --deploy -d fortigate.kiroshi.group --deploy-hook fortigate
```

This assumes:
- `fortigate.sh` is in `~/.acme.sh/deploy/`.
- Your YAML config or env vars point to the correct FortiGate credentials and target VDOM/store.
