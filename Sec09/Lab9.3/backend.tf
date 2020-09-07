terraform {
  backend azurerm {
      resource_group_name  = "Terra-rg"
      storage_account_name = "remotesa01"
      container_name       = "tfstate"
      key                  = "Lab93.tfstate"
  }
}