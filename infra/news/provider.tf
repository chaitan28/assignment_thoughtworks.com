# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.99"
    }
  }

  backend "azurerm" {
    resource_group_name  = "newsv9_rg_joi_interview"
    storage_account_name = "newsv9sajoiinterview"
    container_name       = "newsv9terraformcontainerjoiinterview"
    key                  = "news/terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "1d342b09-7474-440d-a4c0-4d42e7768976"
}

data "azurerm_resource_group" "azure-resource" {
  name = "news4321_rg_joi_interview"
}

