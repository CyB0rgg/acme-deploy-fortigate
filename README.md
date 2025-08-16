# acme-deploy-fortigate

FortiGate deploy hooks for [acme.sh](https://github.com/acmesh-official/acme.sh) that swap/bind freshly renewed TLS certificates onto a FortiGate device with support for both standard certificates and SSL inspection certificates.

> **Prerequisite**: Requires [fortigate-cert-swap](https://github.com/CyB0rgg/fortigate-cert-swap) v1.11.0+ installed and configured with revolutionary automatic intermediate CA management.

## 🚀 Features

- **🔒 Standard Certificate Mode** (`fortigate.sh`) - GUI/SSL-VPN/FTM service binding with automatic intermediate CA management
- **🔍 SSL Inspection Certificate Mode** (`fortigate_ssl_inspection.sh`) - Automated SSL inspection certificate renewal with profile rebinding
- **🤖 Automatic Intermediate CA Management** - World's first solution to FortiGate's certificate chain design limitation
- **⚙️ YAML Configuration Support** - Preferred configuration method with CLI override capability
- **📝 Comprehensive Logging** - Optional file logging with sensitive data scrubbing

## 📋 Deploy Hook Modes

### Standard Certificates (`fortigate.sh`)
For GUI, SSL-VPN, and FTM service certificates:

```bash
# Standard certificate deployment
acme.sh --deploy -d web.example.com --deploy-hook fortigate
```

**Features:**
- Binds certificates to GUI admin interface
- Binds certificates to SSL-VPN services
- Binds certificates to FTM push notifications
- Automatic intermediate CA management
- Complete certificate chain validation

### SSL Inspection Certificates (`fortigate_ssl_inspection.sh`)
For SSL inspection certificate automation:

```bash
# SSL inspection certificate deployment
acme.sh --deploy -d ssl.example.com --deploy-hook fortigate_ssl_inspection
```

**Features:**
- Standard certificate naming (domain-YYYYMMDD)
- Automatic SSL inspection profile discovery and rebinding
- Multi-profile support for the same domain
- Automatic pruning of old SSL inspection certificates (enabled by default)
- Automatic intermediate CA management
- Complete certificate chain validation

## ⚙️ Configuration

### Environment File Setup
Create persistent configuration files that won't be touched by acme.sh:

**Standard certificates:**
```bash
# ~/.acme.sh/fortigate.env
FORTI_CONFIG="/path/to/fortigate.yaml"
FORTI_LOG="/var/log/fortigate-deploy.log"
FORTI_LOG_LEVEL="standard"
# FORTI_EXTRA="--prune false"  # Uncomment to disable automatic certificate pruning
```

**SSL inspection certificates:**
```bash
# ~/.acme.sh/fortigate_ssl_inspection.env
FORTI_CONFIG="/path/to/ssl-inspection-certificate.yaml"
FORTI_LOG="/var/log/fortigate-ssl-inspection-deploy.log"
FORTI_LOG_LEVEL="standard"
# FORTI_EXTRA="--prune false"  # Uncomment to disable automatic certificate pruning
```

### YAML Configuration Files
Preferred approach using YAML configuration files:

**Standard certificates (`fortigate.yaml`):**
```yaml
# FortiGate connection & behavior
host: fortigate.example.com
port: 8443
token: "YOUR_API_TOKEN"
insecure: false
dry_run: false
prune: true

# Automatic intermediate CA management (NEW in v1.11.0)
auto_intermediate_ca: true

# Optional file logging
log: "/var/log/fortigate-deploy.log"
log_level: "standard"
```

**SSL inspection certificates (`ssl-inspection-certificate.yaml`):**
```yaml
# FortiGate connection & behavior
host: fortigate.example.com
port: 8443
token: "YOUR_API_TOKEN"
insecure: false
dry_run: false
prune: true

# Automatic intermediate CA management (NEW in v1.11.0)
auto_intermediate_ca: true

# Optional file logging
log: "/var/log/fortigate-ssl-inspection-deploy.log"
log_level: "standard"
```

## 🛠️ Installation

1. **Install fortigate-cert-swap v1.11.0+:**
   ```bash
   # Ensure fortigate-cert-swap v1.11.0+ is installed and in PATH
   forti_cert_swap.py --version
   ```

2. **Install deploy hooks:**
   ```bash
   # Copy hooks to acme.sh deploy directory
   cp fortigate.sh ~/.acme.sh/deploy/
   cp fortigate_ssl_inspection.sh ~/.acme.sh/deploy/
   chmod +x ~/.acme.sh/deploy/fortigate.sh
   chmod +x ~/.acme.sh/deploy/fortigate_ssl_inspection.sh
   ```

3. **Configure environment files:**
   ```bash
   # Create configuration files
   cp examples/fortigate.env.example ~/.acme.sh/fortigate.env
   cp examples/fortigate_ssl_inspection.env.example ~/.acme.sh/fortigate_ssl_inspection.env
   
   # Edit with your FortiGate credentials
   nano ~/.acme.sh/fortigate.env
   nano ~/.acme.sh/fortigate_ssl_inspection.env
   ```

## 🔄 Usage Examples

### Standard Certificate Deployment
```bash
# Deploy standard certificate for GUI/SSL-VPN/FTM services
acme.sh --deploy -d web.example.com --deploy-hook fortigate

# With custom configuration
FORTI_CONFIG="/path/to/custom-fortigate.yaml" \
acme.sh --deploy -d web.example.com --deploy-hook fortigate
```

### SSL Inspection Certificate Deployment
```bash
# Deploy SSL inspection certificate with automatic profile rebinding
acme.sh --deploy -d ssl.example.com --deploy-hook fortigate_ssl_inspection

# With pruning of old certificates
FORTI_EXTRA="--prune" \
acme.sh --deploy -d ssl.example.com --deploy-hook fortigate_ssl_inspection
```

## 🔗 Revolutionary v1.11.0 Features

### 🚀 **Automatic Intermediate CA Management**
Both deploy hooks now include the world's first solution to FortiGate's certificate chain design limitation:

- ✅ **Automatic Detection**: Extracts intermediate CAs from certificate chains
- ✅ **Smart Upload**: Only uploads missing intermediate CAs to avoid duplicates
- ✅ **Complete Chains**: Ensures SSL Labs and curl validation without `--insecure`
- ✅ **SSL Inspection Trust**: Enables SSL inspection for uploaded intermediate CAs

**Before v1.11.0:**
- ❌ Manual intermediate CA uploads required
- ❌ SSL Labs warnings about missing certificates
- ❌ curl validation required `--insecure` flag

**After v1.11.0:**
- ✅ Automatic intermediate CA management
- ✅ SSL Labs validation passes without warnings
- ✅ curl validation works without `--insecure` flag

## 🐛 Troubleshooting

### Common Issues

**Hook not found:**
```bash
# Ensure hooks are in the correct location and executable
ls -la ~/.acme.sh/deploy/fortigate*.sh
```

**Configuration issues:**
```bash
# Test configuration with dry-run
FORTI_EXTRA="--dry-run" \
acme.sh --deploy -d test.example.com --deploy-hook fortigate
```

**SSL inspection profile issues:**
```bash
# Check SSL inspection profiles via FortiGate CLI
show firewall ssl-ssh-profile
```

### Debug Mode
Enable debug logging for troubleshooting:
```bash
FORTI_LOG_LEVEL="debug" \
acme.sh --deploy -d example.com --deploy-hook fortigate
```

## 📚 Additional Resources

- [FortiGate Certificate Swap Documentation](https://github.com/CyB0rgg/fortigate-cert-swap)
- [acme.sh Deploy Hook Documentation](https://github.com/acmesh-official/acme.sh/wiki/deployhooks)
- [FortiGate REST API Documentation](https://docs.fortinet.com/document/fortigate/7.4.0/administration-guide/954635/rest-api-administrator)

---

This assumes:
- Deploy hooks are in `~/.acme.sh/deploy/`
- Your YAML config or env vars point to the correct FortiGate credentials and target VDOM/store
- fortigate-cert-swap v1.11.0+ is installed and configured
