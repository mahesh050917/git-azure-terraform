terraform {
  backend "azurerm" {
    resource_group_name  = "terraformrg"
    storage_account_name = "devops32backendtfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
