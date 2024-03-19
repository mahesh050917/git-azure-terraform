resource "azurerm_key_vault_secret" "vm_passwords" {

  count        = 3
  name         = "vmpassword-${count.index}"
  value        = element(random_password.vm_password.*.result, count.index)
  key_vault_id = azurerm_key_vault.demokeyvault.id

  depends_on = [azurerm_key_vault_access_policy.demouserpolicy,
  azurerm_key_vault_access_policy.demopolicy]
}
