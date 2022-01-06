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

# VNETの作成
resource "azurerm_virtual_network" "vnet" {
  address_space       = ["192.168.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  name                = "aciJavaAppVnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Subnetの作成
resource "azurerm_subnet" "subnet1" {
  name                 = "aciJavaAppSubnet1"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["192.168.0.0/24"]

  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# network profileの作成
resource "azurerm_network_profile" "profile" {
  location            = data.azurerm_resource_group.rg.location
  name                = var.profile_name
  resource_group_name = data.azurerm_resource_group.rg.name

  container_network_interface {
    name = "container_if"
    ip_configuration {
      name      = "ipconfig"
      subnet_id = azurerm_subnet.subnet1.id
    }
  }
}

resource "azurerm_container_group" "aci" {
  location            = data.azurerm_resource_group.rg.location
  name                = var.aci_name
  os_type             = "linux"
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_address_type = "Private"
  network_profile_id = azurerm_network_profile.profile.id

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
      port = 8080
      protocol = "TCP"
    }
  }

  container {
    cpu = "0.5"
    image  = "${data.azurerm_container_registry.acr.login_server}/sidecar:latest"
    memory = 1.0
    name   = "sidecar"
  }
}
