data "azurerm_user_assigned_identity" "identity-acr" {
  resource_group_name = data.azurerm_resource_group.azure-resource.name
  name                = "identity-acr"
}

data "azurerm_storage_account" "public-storage-account" {
  name                = "${var.prefix}psa"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
}

data "azurerm_storage_container" "public-storage-container" {
  name                 = "${var.prefix}psc"
  storage_account_name = data.azurerm_storage_account.public-storage-account.name
}

data "azurerm_network_interface" "network-interface-quotes" {
  name                = "network-interface-quotes"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
}

data "azurerm_network_interface" "network-interface-newsfeed" {
  name                = "network-interface-newsfeed"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
}

data "azurerm_network_interface" "network-interface-frontend" {
  name                = "network-interface-frontend"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
}

locals {
  url_static_blob = "https://${data.azurerm_storage_account.public-storage-account.name}.blob.core.windows.net/${data.azurerm_storage_container.public-storage-container.name}"
}

module "quotes_vm" {
  source               = "./modules/vm"
  vm_name              = "quotes"
  resource_group_name  = data.azurerm_resource_group.azure-resource.name
  location             = var.location
  network_interface_id = data.azurerm_network_interface.network-interface-quotes.id
  identity_id          = data.azurerm_user_assigned_identity.identity-acr.id
  container_image      = "${var.prefix}quotes${var.acr_url_default}/${var.prefix}quotes:latest"

  depends_on = [
    data.azurerm_network_interface.network-interface-quotes,
    data.azurerm_user_assigned_identity.identity-acr
  ]
}

module "newsfeed_vm" {
  source               = "./modules/vm"
  vm_name              = "newsfeed"
  resource_group_name  = data.azurerm_resource_group.azure-resource.name
  location             = var.location
  network_interface_id = data.azurerm_network_interface.network-interface-newsfeed.id
  identity_id          = data.azurerm_user_assigned_identity.identity-acr.id
  container_image      = "${var.prefix}newsfeed${var.acr_url_default}/${var.prefix}newsfeed:latest"

  depends_on = [
    data.azurerm_network_interface.network-interface-newsfeed,
    data.azurerm_user_assigned_identity.identity-acr
  ]
}

module "frontend_vm" {
  source               = "./modules/vm"
  vm_name              = "frontend"
  resource_group_name  = data.azurerm_resource_group.azure-resource.name
  location             = var.location
  network_interface_id = data.azurerm_network_interface.network-interface-frontend.id
  identity_id          = data.azurerm_user_assigned_identity.identity-acr.id
  container_image      = "${var.prefix}frontend${var.acr_url_default}/${var.prefix}frontend:latest"

  depends_on = [
    data.azurerm_network_interface.network-interface-frontend,
    data.azurerm_user_assigned_identity.identity-acr
  ]
}


