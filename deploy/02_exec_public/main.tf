provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_container_group" "aci" {
  location            = data.azurerm_resource_group.rg.location
  name                = var.aci_name
  os_type             = "linux"
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_address_type     = "Public"

  image_registry_credential {
    password = data.azurerm_container_registry.acr.admin_password
    server   = data.azurerm_container_registry.acr.login_server
    username = data.azurerm_container_registry.acr.admin_username
  }

  container {
    cpu    = 0.5
    image  = "${data.azurerm_container_registry.acr.login_server}/aci_java_app:latest"
    memory = 1.0
    name   = "aci-java-app"
    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  container {
    cpu    = "0.5"
    image  = "${data.azurerm_container_registry.acr.login_server}/sidecar:latest"
    memory = 1.0
    name   = "sidecar"
  }
}
