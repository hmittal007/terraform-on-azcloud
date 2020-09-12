resource "azurerm_virtual_network" "a" {
  name                = "vnet-A"
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}