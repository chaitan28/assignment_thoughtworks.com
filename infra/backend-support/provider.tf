terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "newsv9_rg_joi_interview"
    storage_account_name = "newsv9sajoiinterview"
    container_name       = "newsv9terraformcontainerjoiinterview"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}