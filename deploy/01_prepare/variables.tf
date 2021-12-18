# resource groupの場所
variable "rg_location" {
  type = string
  default = "japaneast"
  description = "region of resource group"
}
# resource groupの名前
variable "rg_name" {
  type = string
  description = "name of resource group"
}

# Azure Container Registryの名前
variable "acr_name" {
  type = string
  description = "name of Azure Container Registry"
}
