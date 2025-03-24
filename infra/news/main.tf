module "quotes_vm" {
  source               = "./modules/vm"
  vm_name              = "quotes"
  resource_group_name  = data.azurerm_resource_group.azure-resource.name
  location             = var.location
  network_interface_id = data.azurerm_network_interface.network-interface-quotes.id
  identity_id          = data.azurerm_user_assigned_identity.identity-acr.id
  container_image      = "${var.prefix}quotes${var.acr_url_default}/${var.prefix}quotes:latest"
}

module "newsfeed_vm" {
  source               = "./modules/vm"
  vm_name              = "newsfeed"
  resource_group_name  = data.azurerm_resource_group.azure-resource.name
  location             = var.location
  network_interface_id = data.azurerm_network_interface.network-interface-newsfeed.id
  identity_id          = data.azurerm_user_assigned_identity.identity-acr.id
  container_image      = "${var.prefix}newsfeed${var.acr_url_default}/${var.prefix}newsfeed:latest"
}

module "frontend_vm" {
  source               = "./modules/vm"
  vm_name              = "frontend"
  resource_group_name  = data.azurerm_resource_group.azure-resource.name
  location             = var.location
  network_interface_id = data.azurerm_network_interface.network-interface-frontend.id
  identity_id          = data.azurerm_user_assigned_identity.identity-acr.id
  container_image      = "${var.prefix}frontend${var.acr_url_default}/${var.prefix}frontend:latest"
}
