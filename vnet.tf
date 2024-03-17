resource "azurerm_virtual_network" "demo_vnet1" {
  name                = "${azurerm_resource_group.rg1}-vnet1"
  address_space       = var.vnet1_cidr
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  tags = {
    env   = var.env
    batch = var.batch
  }
}
