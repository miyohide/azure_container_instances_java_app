provider "azurerm" {
  features {}
}

# resource groupの作成
resource "azurerm_resource_group" "rg" {
  location = var.rg_location
  name     = var.rg_name
}

# Azure Container Registryの作成
resource "azurerm_container_registry" "acr" {
  location            = azurerm_resource_group.rg.location
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  admin_enabled       = true
}
