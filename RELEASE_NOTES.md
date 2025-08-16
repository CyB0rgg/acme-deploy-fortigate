# Release Notes - acme-deploy-fortigate v2.0.0

## 🚀 Revolutionary Dual-Mode ACME Deploy Hook Support

**Release Date:** August 16, 2025

### 🎯 **What's New**

**acme-deploy-fortigate v2.0.0** introduces groundbreaking dual-mode support for FortiGate certificate automation, making it the **first ACME integration** to provide complete workflows for both standard certificates and SSL inspection certificates.

### 🔥 **Key Features**

#### **🔒 Standard Certificate Mode** (`fortigate.sh`)
- **GUI/SSL-VPN/FTM Service Binding** - Automatic binding to FortiGate admin services
- **Automatic Intermediate CA Management** - World's first solution to FortiGate's certificate chain limitation
- **Complete Certificate Chain Validation** - SSL Labs and curl validation without `--insecure`

#### **🔍 SSL Inspection Certificate Mode** (`fortigate_ssl_inspection.sh`)
- **Automated SSL Inspection Workflows** - Complete certificate renewal automation
- **Smart Profile Discovery** - Automatic SSL inspection profile detection and rebinding
- **Multi-Profile Support** - Handles multiple profiles using the same certificate domain
- **Standard Naming Convention** - Uses domain-YYYYMMDD format for consistency
- **Automatic Certificate Pruning** - Automatic cleanup of old certificates (enabled by default)

### 🤖 **Revolutionary Technology Integration**

#### **Automatic Intermediate CA Management**
Seamlessly integrates with **fortigate-cert-swap v1.11.0's** revolutionary features:

- ✅ **Automatic Detection** - Extracts intermediate CAs from certificate chains
- ✅ **Smart Upload** - Only uploads missing intermediate CAs to prevent duplicates
- ✅ **Complete Chains** - Ensures SSL Labs validation without warnings
- ✅ **SSL Inspection Trust** - Enables SSL inspection for uploaded intermediate CAs

**Before v2.0.0:**
- ❌ Manual intermediate CA uploads required
- ❌ SSL Labs warnings about missing certificates
- ❌ No SSL inspection certificate automation

**After v2.0.0:**
- ✅ Automatic intermediate CA management
- ✅ Complete SSL inspection certificate automation
- ✅ SSL Labs validation passes without warnings

### 📋 **Usage Examples**

#### **Standard Certificates**
```bash
# Deploy standard certificate for GUI/SSL-VPN/FTM services
acme.sh --deploy -d web.example.com --deploy-hook fortigate
```

#### **SSL Inspection Certificates**
```bash
# Deploy SSL inspection certificate with automatic profile rebinding
acme.sh --deploy -d ssl.example.com --deploy-hook fortigate_ssl_inspection
```

### ⚙️ **Configuration Management**

#### **Separate Environment Files**
- **Standard certificates:** `~/.acme.sh/fortigate.env`
- **SSL inspection certificates:** `~/.acme.sh/fortigate_ssl_inspection.env`

#### **Mode-Specific YAML Configurations**
- **Standard certificates:** `fortigate.yaml`
- **SSL inspection certificates:** `ssl-inspection-certificate.yaml`

### 🔧 **Installation**

```bash
# Copy both hooks to acme.sh deploy directory
cp fortigate.sh ~/.acme.sh/deploy/
cp fortigate_ssl_inspection.sh ~/.acme.sh/deploy/
chmod +x ~/.acme.sh/deploy/fortigate*.sh

# Create configuration files
cp examples/fortigate.env.example ~/.acme.sh/fortigate.env
cp examples/fortigate_ssl_inspection.env.example ~/.acme.sh/fortigate_ssl_inspection.env
```

### 📈 **Technical Breakthrough**

#### **Domain-Specific Hook Selection**
Enables acme.sh to automatically call the correct hook during renewals based on initial setup:

- **Standard domains** → `fortigate.sh` → GUI/SSL-VPN/FTM binding
- **SSL inspection domains** → `fortigate_ssl_inspection.sh` → SSL inspection profile rebinding

#### **Complete Certificate Chain Management**
Both hooks now provide complete certificate chain functionality:

- **Leaf Certificate Upload** - Standard certificate upload to local store
- **Intermediate CA Management** - Automatic intermediate CA upload to CA store
- **Service Binding** - Mode-specific service binding (GUI/SSL-VPN vs SSL inspection)
- **Chain Validation** - Complete certificate chain presentation

### 🚨 **Breaking Changes**

#### **Version Requirement**
- **Required:** fortigate-cert-swap v1.11.0+ (upgraded from v1.8.0+)
- **Reason:** Automatic intermediate CA management and SSL inspection certificate support

#### **Configuration Structure**
- **Recommended:** Separate environment files for each mode
- **Benefit:** Clear separation of standard vs SSL inspection certificate workflows

### 🔄 **Migration Guide**

#### **From v1.x to v2.0.0**

1. **Update Backend:**
   ```bash
   # Ensure fortigate-cert-swap v1.11.0+ is installed
   forti_cert_swap.py --version
   ```

2. **Install New Hook:**
   ```bash
   # Copy SSL inspection hook
   cp fortigate_ssl_inspection.sh ~/.acme.sh/deploy/
   chmod +x ~/.acme.sh/deploy/fortigate_ssl_inspection.sh
   ```

3. **Update Configuration:**
   ```bash
   # Create SSL inspection environment file (if needed)
   cp examples/fortigate_ssl_inspection.env.example ~/.acme.sh/fortigate_ssl_inspection.env
   ```

4. **No Changes Required:**
   - Existing `fortigate.sh` deployments continue to work
   - Existing environment files remain compatible
   - All existing acme.sh configurations preserved

### 🎯 **Production Benefits**

#### **For Standard Certificates**
- ✅ Automatic intermediate CA management
- ✅ Complete certificate chain validation
- ✅ SSL Labs compliance without manual intervention

#### **For SSL Inspection Certificates**
- ✅ Complete automation of SSL inspection certificate renewals
- ✅ Automatic profile discovery and rebinding
- ✅ Multi-profile support for complex environments
- ✅ Standard naming conventions for consistency

### 🔗 **Resources**

- **Documentation:** [README.md](README.md)
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)
- **Backend Tool:** [fortigate-cert-swap v1.11.0+](https://github.com/CyB0rgg/fortigate-cert-swap)
- **ACME Client:** [acme.sh](https://github.com/acmesh-official/acme.sh)

### 🏆 **Industry Impact**

**acme-deploy-fortigate v2.0.0** establishes the **first and only ACME integration** to provide:

- ✅ **Complete SSL inspection certificate automation**
- ✅ **Automatic intermediate CA management for FortiGate**
- ✅ **Dual-mode certificate deployment workflows**
- ✅ **Production-ready SSL inspection profile management**

This release makes FortiGate certificate automation **truly enterprise-ready** with zero manual intervention required for both standard and SSL inspection certificate workflows.

---

**Ready to deploy!** 🚀

Test the new SSL inspection hook and experience the world's most advanced FortiGate certificate automation.