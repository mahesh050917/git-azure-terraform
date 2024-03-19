output "demo_vm_publcip" {
  value = azurerm_public_ip.demo_vm_publcip.*.ip_address
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.demo_vms.*.name
}
