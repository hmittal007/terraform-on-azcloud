resource "azurerm_resource_group" "mg-rg" {
  name     = "${var.env}-rg"
  location = var.location-name
}

module "mg-vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = "${var.env}-vnet"
  depends_on          = [azurerm_resource_group.mg-rg]
  resource_group_name = azurerm_resource_group.mg-rg.name
  address_space       = ["10.0.4.0/23"]
  subnet_prefixes     = ["10.0.4.0/24"]
  subnet_names        = ["${var.env}-subnet"]
  tags                = null
}

resource "azurerm_public_ip" "mg-rg" {
  name                = "${var.env}-pub-ip01"
  location            = azurerm_resource_group.mg-rg.location
  resource_group_name = azurerm_resource_group.mg-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "mg-vm" {
  name                = "${var.env}-nic"
  location            = azurerm_resource_group.mg-rg.location
  resource_group_name = azurerm_resource_group.mg-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.mg-vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mg-rg.id
  }
}

resource "azurerm_network_security_group" "mg-vm" {
  name                = "${var.env}-nsg"
  location            = azurerm_resource_group.mg-rg.location
  resource_group_name = azurerm_resource_group.mg-rg.name
}

resource "azurerm_virtual_machine" "mg-vm" {
  name                  = "${var.env}-vm01"
  location              = azurerm_resource_group.mg-rg.location
  resource_group_name   = azurerm_resource_group.mg-rg.name
  network_interface_ids = [azurerm_network_interface.mg-vm.id]
  vm_size               = "Standard_B2s"
  identity {
    type = "SystemAssigned"
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.env}-osdisk"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }
  os_profile {
    computer_name  = "${var.env}-vm01"
    admin_username = "testadmin"
    admin_password = var.admin_password
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
}

resource "azurerm_network_security_rule" "mg-vm" {
  name                        = "rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "${var.access-from}/32"
  destination_address_prefix  = "${azurerm_network_interface.mg-vm.private_ip_address}/32"
  resource_group_name         = azurerm_resource_group.mg-rg.name
  network_security_group_name = azurerm_network_security_group.mg-vm.name
}

resource "azurerm_network_interface_security_group_association" "mg-vm" {
  network_interface_id      = azurerm_network_interface.mg-vm.id
  network_security_group_id = azurerm_network_security_group.mg-vm.id
}

data "azurerm_subscription" "current" {}

resource "azurerm_role_assignment" "mg-vm" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_virtual_machine.mg-vm.identity[0].principal_id
}

#refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/managed_service_identity