resource "azurerm_storage_account" "demostg" {
  count                    = 3
  name                     = "demostgdevops${count.index}"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    env   = var.env
    batch = var.batch
  }
}
