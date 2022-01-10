terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "stmiyohidetfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
