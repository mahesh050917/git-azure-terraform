resource "azurerm_key_vault_secret" "vm_passwords" {
  count        = 3
  name         = "vmpassword-${count.index + 1}"
  value        = element(random_password.vm_password.*.result, count.index)
  key_vault_id = azurerm_key_vault.demokeyvault.id
}
