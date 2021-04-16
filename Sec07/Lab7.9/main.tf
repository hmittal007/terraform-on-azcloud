terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.41.0"
      configuration_aliases = [ azurerm.alt ]
    }
  }
  backend "azurerm" {
    resource_group_name  = "Backend_rg"
    storage_account_name = "backendsa01"
    container_name       = "tfstate"
    key                  = "statefilename.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "default-sub_id"
}

provider "azurerm" {
  alias = "alt"
  features {}
  subscription_id = "second-sub-id"
}

resource "azurerm_resource_group" "example1" { 
  name     = "provider1"
  location = "West Europe"
}

resource "azurerm_resource_group" "example2" {
  provider = azurerm.alt
  name     = "provider2"
  location = "West Europe"
}

resource "azurerm_storage_account" "example2" {
  provider = azurerm.alt
  name                     = "testsao1234"
  resource_group_name      = azurerm_resource_group.example2.name
  location                 = azurerm_resource_group.example2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "pkey" {
  value = azurerm_storage_account.example2.primary_access_key
  sensitive =true
}