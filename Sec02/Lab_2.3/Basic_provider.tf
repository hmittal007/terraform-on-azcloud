# a basic azure provider, uses your azure cli session credentials to get authenticated with azure cloud.
# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards

provider "azurerm" {
  features {}
}

