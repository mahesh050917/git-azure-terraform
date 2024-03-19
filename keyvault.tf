data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "demokeyvault" {
  name                        = "devopskeyvaultb32"
  location                    = azurerm_resource_group.rg1.location
  resource_group_name         = azurerm_resource_group.rg1.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "demopolicy" {
  key_vault_id = azurerm_key_vault.demokeyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  secret_permissions = [
    "Get",
    "Backup",
    "Delete",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]
}


resource "azurerm_key_vault_access_policy" "demouserpolicy" {
  key_vault_id = azurerm_key_vault.demokeyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "7859f522-faeb-40d7-b682-13404a936db6"
  secret_permissions = [
    "Get",
    "Backup",
    "Delete",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]
}
