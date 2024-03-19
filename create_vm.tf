resource "azurerm_public_ip" "demo_vm_publcip" {
  count               = 0
  name                = "vm-publicip-${count.index}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"

  tags = {
    env   = var.env
    batch = var.batch
  }
}


resource "azurerm_network_interface" "demo_vm_nic" {
  count               = 0
  name                = "vm-nic-${count.index}"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "vm-ipconfig"
    subnet_id                     = element(azurerm_subnet.demo_subnet.*.id, count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.demo_vm_publcip.*.id, count.index)
  }
}

resource "azurerm_linux_virtual_machine" "demo_vms" {
  count               = 0
  name                = "linuxvm-${count.index}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = var.sku_size
  admin_username      = var.vm_username
  admin_password      = element(azurerm_key_vault_secret.vm_passwords.*.value, count.index)
  network_interface_ids = [
    element(azurerm_network_interface.demo_vm_nic.*.id, count.index)
  ]
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
