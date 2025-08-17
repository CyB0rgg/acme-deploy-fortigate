# acme-deploy-fortigate

FortiGate deploy hooks for [acme.sh](https://github.com/acmesh-official/acme.sh) that swap/bind freshly renewed TLS certificates onto a FortiGate device with support for both standard certificates and SSL inspection certificates.

> **Prerequisite**: Requires [fortigate-cert-swap](https://github.com/CyB0rgg/fortigate-cert-swap) v2.0.0+ Go binary installed with revolutionary automatic intermediate CA management and 13.4x performance improvement.

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
FORTI_CONFIG="/path/to/fortigate.yaml"
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

# Automatic intermediate CA management (Enhanced in v2.0.0)
auto_intermediate_ca: true

# Optional file logging
log: "/var/log/fortigate-deploy.log"
log_level: "standard"
```

## 🛠️ Installation

1. **Install fortigate-cert-swap v2.0.0+ Go binary:**
   ```bash
   # Linux x64
   wget https://github.com/CyB0rgg/fortigate-cert-swap/releases/latest/download/fortigate-cert-swap-linux-amd64
   chmod +x fortigate-cert-swap-linux-amd64
   sudo mv fortigate-cert-swap-linux-amd64 /usr/local/bin/fortigate-cert-swap
   
   # macOS Apple Silicon (M1/M2/M3/M4)
   wget https://github.com/CyB0rgg/fortigate-cert-swap/releases/latest/download/fortigate-cert-swap-darwin-arm64
   chmod +x fortigate-cert-swap-darwin-arm64
   sudo mv fortigate-cert-swap-darwin-arm64 /usr/local/bin/fortigate-cert-swap
   
   # macOS Intel
   wget https://github.com/CyB0rgg/fortigate-cert-swap/releases/latest/download/fortigate-cert-swap-darwin-amd64
   chmod +x fortigate-cert-swap-darwin-amd64
   sudo mv fortigate-cert-swap-darwin-amd64 /usr/local/bin/fortigate-cert-swap
   
   # Windows x64 - Download fortigate-cert-swap-windows-amd64.exe and place in PATH
   
   # Verify installation
   fortigate-cert-swap --version
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

## 🚀 Revolutionary v2.0.0+ Go Binary Features

### ⚡ **13.4x Performance Improvement**
The Go binary delivers unprecedented performance improvements:

- ✅ **13.4x Faster Startup**: 0.026s vs 0.348s (Python version)
- ✅ **Native Binary**: Single 6.5MB executable with zero dependencies
- ✅ **Cross-Platform**: Linux (x64/ARM64), macOS (Intel/Apple Silicon), Windows (x64)
- ✅ **Instant Deployment**: No Python installation required

### 🚀 **Enhanced Automatic Intermediate CA Management**
Both deploy hooks include the world's first solution to FortiGate's certificate chain design limitation:

- ✅ **Automatic Detection**: Extracts intermediate CAs from certificate chains
- ✅ **Smart Upload**: Only uploads missing intermediate CAs to avoid duplicates
- ✅ **Complete Chains**: Ensures SSL Labs and curl validation without `--insecure`
- ✅ **SSL Inspection Trust**: Enables SSL inspection for uploaded intermediate CAs
- ✅ **Enhanced Performance**: 13.4x faster certificate processing

**Before v2.0.0:**
- ❌ Python dependency management required
- ❌ Slower certificate processing (0.348s startup)
- ❌ Platform-specific installation complexity

**After v2.0.0:**
- ✅ Single native binary with zero dependencies
- ✅ 13.4x faster certificate processing (0.026s startup)
- ✅ Cross-platform compatibility with consistent behavior
- ✅ Enhanced automatic intermediate CA management

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
- fortigate-cert-swap v2.0.0+ Go binary is installed and configured

---

**Copyright (c) 2025 CyB0rgg <dev@bluco.re>**
**Licensed under the MIT License**
