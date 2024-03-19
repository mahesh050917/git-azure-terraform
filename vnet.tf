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


resource "azurerm_subnet" "private_subnet" {
  name                 = "${azurerm_virtual_network.demo_vnet1.name}-privatesubnet"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.demo_vnet1.name
  address_prefixes     = var.privatesubnet_cidr
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.rg1.name

}


resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_network_links" {
  name                  = "${azurerm_virtual_network.demo_vnet1.name}-link"
  resource_group_name   = azurerm_resource_group.rg1.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zones.name
  virtual_network_id    = azurerm_virtual_network.demo_vnet1.id
}

