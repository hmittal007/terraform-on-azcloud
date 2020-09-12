provider "azurerm" {
  version = "~> 2.18"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "test-rg"
  location = "West Europe"
}