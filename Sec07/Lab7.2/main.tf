resource "azurerm_resource_group" "abc" {
  name     = var.rg
  location = var.location
}

resource "azurerm_virtual_network" "a" {
  name                = "vnet-A"
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.abc.location
  resource_group_name = azurerm_resource_group.abc.name
}

resource "azurerm_virtual_network" "b" {
  name                = "vnet-B"
  address_space       = ["10.0.2.0/24"]
  location            = azurerm_resource_group.abc.location
  resource_group_name = azurerm_resource_group.abc.name
  depends_on          = [azurerm_virtual_network.a]
}