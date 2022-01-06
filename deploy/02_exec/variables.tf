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

# Azure Container Instancesの名前
variable "aci_name" {
  type = string
  description = "name of Azure Container Instances"
}

# Azure Network Profileの名前
variable "profile_name" {
  type = string
  description = "name of Azure Network Profile"
}
