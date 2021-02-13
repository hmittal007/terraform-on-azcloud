#rg fe-rg
#pip pub-ip01
#fw  fw-01
#vnet fe-vnet
# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards

resource "azurerm_resource_group" "fe-rg" {
  name     = var.fe-rg-name
  location = var.location-name
}

resource "azurerm_virtual_network" "fe-rg" {
  name                = var.fe-vnet-name
  address_space       = ["10.0.0.0/23"]
  location            = azurerm_resource_group.fe-rg.location
  resource_group_name = azurerm_resource_group.fe-rg.name
}

resource "azurerm_subnet" "fe-rg-01" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.fe-rg.name
  virtual_network_name = azurerm_virtual_network.fe-rg.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "fe-rg-02" {
  name                 = var.jb-sub-name
  resource_group_name  = azurerm_resource_group.fe-rg.name
  virtual_network_name = azurerm_virtual_network.fe-rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "fe-rg" {
  name                = var.pip-name
  location            = azurerm_resource_group.fe-rg.location
  resource_group_name = azurerm_resource_group.fe-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fe-rg" {
  name                = var.fw-name
  location            = azurerm_resource_group.fe-rg.location
  resource_group_name = azurerm_resource_group.fe-rg.name
  ip_configuration {
    name                 = "fwip-config"
    subnet_id            = azurerm_subnet.fe-rg-01.id
    public_ip_address_id = azurerm_public_ip.fe-rg.id
  }
}