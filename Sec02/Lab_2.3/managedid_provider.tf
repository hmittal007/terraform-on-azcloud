/*

1. Like service principal account, we can create a managed identity.
2. assign a contributer role to managed identity.
3. and then managed identity account can be assigned to Terraform VM host.
 then you can run or deploy terraform configuration files from that vm
 by using the provider block given below.
*/

provider "azurerm" {
    use_msi = true
}