# Changelog

All notable changes to this project will be documented in this file.

## [2.1.0] - 2025-08-17

### 🚀 Go Binary Migration - 13.4x Performance Improvement

#### **Major Changes**
- **🔄 Go Binary Migration** - Updated from Python `forti_cert_swap.py` to Go `fortigate-cert-swap` binary
- **⚡ 13.4x Performance Improvement** - Startup time reduced from 0.348s to 0.026s
- **🗂️ Zero Dependencies** - Single native binary with no Python installation required
- **🌐 Cross-Platform Binaries** - Linux (x64/ARM64), macOS (Intel/Apple Silicon), Windows (x64)

#### **Breaking Changes**
- **Binary Name:** `forti_cert_swap.py` → `fortigate-cert-swap`
- **Configuration Flag:** `-C config.yaml` → `--config config.yaml` (short flag removed)
- **SSL Inspection Flag:** `--ssl-inspection-certificate` → `--ssl-inspection-cert`
- **Version Requirement:** Updated from `v1.11.0+` to `v2.0.0+`

#### **Enhanced Installation**
- **Direct Binary Download** from GitHub releases
- **No Python Dependencies** required
- **Instant Deployment** with single executable

#### **Migration Guide**
1. **Download Go Binary:**
   ```bash
   # Linux x64
   wget https://github.com/CyB0rgg/fortigate-cert-swap/releases/latest/download/fortigate-cert-swap-linux-amd64
   chmod +x fortigate-cert-swap-linux-amd64
   sudo mv fortigate-cert-swap-linux-amd64 /usr/local/bin/fortigate-cert-swap
   ```

2. **Update Deploy Hooks:**
   - Copy updated `fortigate.sh` and `fortigate_ssl_inspection.sh`
   - Environment files work unchanged (optional `FORTI_BIN` update)

3. **Test Installation:**
   ```bash
   fortigate-cert-swap --version  # Should show v2.0.0+
   ```

#### **Maintained Compatibility**
- ✅ **100% Functional Parity** with Python version
- ✅ **Same YAML Configuration Files** work unchanged
- ✅ **Same Environment Variables** supported
- ✅ **Same acme.sh Integration** behavior preserved

## [2.0.0] - 2025-08-16

### Added
- **🚀 REVOLUTIONARY: Dual-Mode ACME Deploy Hook Support** - First ACME integration to support both standard and SSL inspection certificate workflows
- **🔍 SSL Inspection Certificate Mode** (`fortigate_ssl_inspection.sh`) - Complete automated SSL inspection certificate renewal workflow
  - Automatic SSL inspection profile discovery and rebinding
  - Multi-profile support for the same domain
  - Standard certificate naming (domain-YYYYMMDD)
  - Automatic pruning of old SSL inspection certificates (enabled by default)
- **🤖 Automatic Intermediate CA Management Integration** - Seamless integration with fortigate-cert-swap v1.11.0's revolutionary intermediate CA features
  - World's first solution to FortiGate's certificate chain design limitation
  - Complete certificate chain validation without SSL Labs warnings
  - curl validation works without `--insecure` flag
- **⚙️ Enhanced Configuration Management**
  - Separate environment files for each mode (`fortigate.env` vs `fortigate_ssl_inspection.env`)
  - Mode-specific YAML configuration examples
  - Comprehensive documentation with usage examples
- **📝 Production-Ready Documentation**
  - Complete usage guide for both deployment modes
  - Troubleshooting section with common issues
  - Installation and configuration instructions
  - Integration examples with real-world scenarios

### Enhanced
- **Standard Certificate Mode** (`fortigate.sh`) - Updated to leverage fortigate-cert-swap v1.11.0+ features
  - Automatic intermediate CA management
  - Enhanced logging and error handling
  - Complete certificate chain validation
- **User Experience** - Clear separation between standard and SSL inspection certificate workflows
- **Documentation** - Comprehensive README with feature comparison and usage examples

### Changed
- **Version Requirement** - Now requires fortigate-cert-swap v1.11.0+ (upgraded from v1.8.0+)
- **Hook Architecture** - Dual-hook approach for predictable acme.sh automation behavior
- **Configuration Structure** - Mode-specific environment files and YAML configurations

### Technical Breakthrough
- **Domain-Specific Hook Selection** - Enables acme.sh to automatically call the correct hook during renewals based on initial setup
- **SSL Inspection Automation** - First ACME deploy hook to provide complete SSL inspection certificate automation
- **Certificate Chain Completeness** - Automatic intermediate CA management ensures complete certificate chains for all modes

### Breaking Changes
- **Version Requirement** - Requires fortigate-cert-swap v1.11.0+ for automatic intermediate CA management
- **Configuration Files** - Separate environment files recommended for each mode

### Migration Guide
- Update fortigate-cert-swap to v1.11.0+
- Copy `fortigate_ssl_inspection.sh` to `~/.acme.sh/deploy/`
- Create separate environment files for each mode if using SSL inspection certificates
- Update existing `fortigate.env` files to reference v1.11.0+ features

## [1.0.1] - 2025-08-10
### Fixed
- Mark deploy hook executable (`chmod +x fortigate.sh`).

## [1.0.0] - 2025-08-10
### Added
- Initial release of acme-deploy-fortigate.
- Supports passing fullchain + key from acme.sh to fortigate-cert-swap.
- Allows overrides via CLI args or environment variables.

---

**Copyright (c) 2025 CyB0rgg <dev@bluco.re>**
**Licensed under the MIT License**