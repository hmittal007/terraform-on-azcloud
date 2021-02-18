# a basic azure provider, uses your azure cli session credentials to get authenticated with azure cloud.
# Please use terraform v14, we will learn more about terraform v 14 later in lab 7.6

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.18"
    }
  }
}

provider "azurerm" {
  features {}
}

