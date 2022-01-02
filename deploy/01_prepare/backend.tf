terraform {
  backend "azurerm" {
    resource_group_name = "tfstate"
    storage_account_name = "tfstate13131"
    container_name = "tfstate01prepare"
    key = "terraform.tfstate"
  }
}