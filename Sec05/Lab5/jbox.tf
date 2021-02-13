/*rg jbox-rg
vm jbox-vm01
nic jbox-nic
nsg jbox-nsg*/
# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards

resource "azurerm_resource_group" "jbox-rg" {
  name     = var.jb-rg-name
  location = var.location-name
}
resource "azurerm_network_interface" "jbox-rg" {
  name                = "${var.jb-vm-name}-nic"
  location            = azurerm_resource_group.jbox-rg.location
  resource_group_name = azurerm_resource_group.jbox-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.fe-rg-02.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "jbox-rg" {
  name                = "${var.jb-vm-name}-nsg"
  location            = azurerm_resource_group.jbox-rg.location
  resource_group_name = azurerm_resource_group.jbox-rg.name
}

resource "azurerm_network_security_rule" "jbox-rg" {
  name                        = "rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_network_interface.jbox-rg.private_ip_address}/32"
  resource_group_name         = azurerm_resource_group.jbox-rg.name
  network_security_group_name = azurerm_network_security_group.jbox-rg.name
}

resource "azurerm_network_interface_security_group_association" "jbox-rg" {
  network_interface_id      = azurerm_network_interface.jbox-rg.id
  network_security_group_id = azurerm_network_security_group.jbox-rg.id
}

resource "azurerm_virtual_machine" "jbox-rg" {
  name                  = "${var.jb-vm-name}-vm01"
  location              = azurerm_resource_group.jbox-rg.location
  resource_group_name   = azurerm_resource_group.jbox-rg.name
  network_interface_ids = [azurerm_network_interface.jbox-rg.id]
  vm_size               = "Standard_B2s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.jb-vm-name}-osdisk"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "${var.jb-vm-name}-vm01"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
}
