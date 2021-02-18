terraform {
  #backend "azurerm" {}
   #terraform v0.14
  required_providers {
    az = {
      source = "hashicorp/azurerm"
      version = "= 2.18"
    }
  }
}