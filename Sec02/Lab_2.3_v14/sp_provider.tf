# an azure provider configuration, using service principal account.
# create a service principal by running the following command in azure cli
#az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
/* we will get following output after running the above command.
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
you can test these login details by running this command
az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID
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
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.4.0"

  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "0000-0000-0000-0000-000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"

  features {}
}