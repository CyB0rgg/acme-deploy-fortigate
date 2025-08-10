# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1] - 2025-08-10
### Fixed
- Mark deploy hook executable (`chmod +x fortigate.sh`).

## [1.0.0] - 2025-08-10
### Added
- Initial release of acme-deploy-fortigate.
- Supports passing fullchain + key from acme.sh to fortigate-cert-swap.
- Allows overrides via CLI args or environment variables.