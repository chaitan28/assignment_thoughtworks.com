# User-Assigned Identity
resource "azurerm_user_assigned_identity" "identity-acr" {
  resource_group_name = data.azurerm_resource_group.azure-resource.name
  location            = var.location
  name                = "identity-acr"
}

# Azure Container Registries (ACRs)
resource "azurerm_container_registry" "quotes" {
  name                = "${var.prefix}quotes"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
  public_network_access_enabled = true  # Enable public access
}

resource "azurerm_container_registry" "newsfeed" {
  name                = "${var.prefix}newsfeed"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
  public_network_access_enabled = true  # Enable public access
}

resource "azurerm_container_registry" "frontend" {
  name                = "${var.prefix}frontend"
  resource_group_name = data.azurerm_resource_group.azure-resource.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
  public_network_access_enabled = true  # Enable public access
}

# Random UUIDs for Role Assignments (AcrPush only)
resource "random_uuid" "acrpush_id_quotes" {
  keepers = {
    acr_id = azurerm_container_registry.quotes.id
    sp_id  = azurerm_user_assigned_identity.identity-acr.principal_id
    role   = "AcrPush"
  }
}

resource "random_uuid" "acrpush_id_newsfeed" {
  keepers = {
    acr_id = azurerm_container_registry.newsfeed.id
    sp_id  = azurerm_user_assigned_identity.identity-acr.principal_id
    role   = "AcrPush"
  }
}

resource "random_uuid" "acrpush_id_frontend" {
  keepers = {
    acr_id = azurerm_container_registry.frontend.id
    sp_id  = azurerm_user_assigned_identity.identity-acr.principal_id
    role   = "AcrPush"
  }
}

# Role Definition for AcrPush
data "azurerm_role_definition" "acrpush" {
  name = "AcrPush"
}

# Role Assignments for AcrPush
resource "azurerm_role_assignment" "acr_acrpush_quotes" {
  name               = random_uuid.acrpush_id_quotes.result
  scope              = azurerm_container_registry.quotes.id
  role_definition_id = data.azurerm_role_definition.acrpush.id
  principal_id       = azurerm_user_assigned_identity.identity-acr.principal_id
}

resource "azurerm_role_assignment" "acr_acrpush_newsfeed" {
  name               = random_uuid.acrpush_id_newsfeed.result
  scope              = azurerm_container_registry.newsfeed.id
  role_definition_id = data.azurerm_role_definition.acrpush.id
  principal_id       = azurerm_user_assigned_identity.identity-acr.principal_id
}

resource "azurerm_role_assignment" "acr_acrpush_frontend" {
  name               = random_uuid.acrpush_id_frontend.result
  scope              = azurerm_container_registry.frontend.id
  role_definition_id = data.azurerm_role_definition.acrpush.id
  principal_id       = azurerm_user_assigned_identity.identity-acr.principal_id
}

# Local Variables
locals {
  acr_url = ".azurecr.io"
}

# Output to File
resource "local_file" "acr" {
  filename = "${path.module}/../acr-url.txt"
  content  = local.acr_url
}