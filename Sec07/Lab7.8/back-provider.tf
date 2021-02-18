terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "= 2.18"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.vsubscription_id
  tenant_id       = var.vtenant_id
  use_msi = true
}