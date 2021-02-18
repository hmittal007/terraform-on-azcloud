/*
There are lab 7.7 and 7.8 on Managed Identity.
# Please use terraform v12.29 to start with for all labs, I will use terraform v13 from lab 7.5 onwards
1. Like service principal account, we can create a managed identity.
2. assign a contributer role to managed identity.
3. and then managed identity account can be assigned to Terraform VM host.
 then you can run or deploy terraform configuration files from that vm
 by using the provider block given below.
*/
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
    use_msi = true
}