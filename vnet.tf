resource "azurerm_virtual_network" "demo_vnet1" {
  name                = "${azurerm_resource_group.rg1.name}-vnet1"
  address_space       = [var.vnet1_cidr]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  tags = {
    env   = var.env
    batch = var.batch
  }
}


resource "azurerm_virtual_network" "demo_vnet2" {
  name                = "${azurerm_resource_group.rg1.name}-vnet2"
  address_space       = [var.vnet2_cidr]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  tags = {
    env   = var.env
    batch = var.batch
  }
}


resource "azurerm_subnet" "demo_subnet" {
  count                = 3
  name                 = "${azurerm_virtual_network.demo_vnet1.name}-subnet${count.index}"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.demo_vnet1.name
  address_prefixes     = [element(var.subnet_cidr, count.index)]
}

