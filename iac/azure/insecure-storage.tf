# IAC scanner testing fixture - Azure Terraform with known misconfigurations

# CKV_AZURE_1 - Storage account allows public network access
# CKV_AZURE_33 - Storage account queue logging not enabled
# CKV_AZURE_35 - Storage account default network access set to Allow
# CKV_AZURE_43 - Storage account name uses minimum number of characters
# CKV_AZURE_59 - Storage account allows public access to blobs
resource "azurerm_storage_account" "insecure" {
  name                            = "insecurestorage1"
  resource_group_name             = "test-rg"
  location                        = "eastus"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true
  public_network_access_enabled   = true
  min_tls_version                 = "TLS1_0" # CKV_AZURE_44 - TLS version too low

  network_rules {
    default_action = "Allow"
  }
}

# CKV_AZURE_50 - VM doesn't have managed identity
# CKV_AZURE_149 - VM has password authentication enabled
# Hardcoded password (also triggers secrets scanner)
resource "azurerm_linux_virtual_machine" "insecure_vm" {
  name                            = "insecure-vm"
  resource_group_name             = "test-rg"
  location                        = "eastus"
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  admin_password                  = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids           = []
}

# CKV_AZURE_4 - AKS cluster logging to Azure Monitoring not configured
# CKV_AZURE_5 - AKS RBAC not enabled
resource "azurerm_kubernetes_cluster" "insecure_aks" {
  name                = "insecure-aks"
  location            = "eastus"
  resource_group_name = "test-rg"
  dns_prefix          = "insecureaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = false
}
