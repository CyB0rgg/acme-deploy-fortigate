# Changelog

All notable changes to this project will be documented in this file.

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