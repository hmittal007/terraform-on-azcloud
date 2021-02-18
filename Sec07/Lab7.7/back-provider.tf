terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.18"
    }
  }
}

# refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

provider "azurerm" {
  features {}
}