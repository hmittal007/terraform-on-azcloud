# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards
provider "azurerm" {
  version = "= 2.18"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "Terra-rg"
  location = "West Europe"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "rg" {
  name                = "kvult-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get", "list", "create", "delete", "update",
    ]
    secret_permissions = [
      "get", "list", "set", "delete",
    ]
  }
}


/*resource "azurerm_storage_account" "rg" {
  name                     = "remotesa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}*/

resource "azurerm_storage_account" "sa01"{
  account_tier = "Standard"
  location = "westeurope"
  account_replication_type = "LRS"
  resource_group_name = "Terra-rg"
  name = "remotesa01"
}