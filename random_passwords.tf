resource "random_password" "vm_password" {
  count            = 3
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
