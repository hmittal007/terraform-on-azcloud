resource "azurerm_network_interface" "compute" {
  name                = "${var.vm-name}-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "compute" {
  name                = "${var.vm-name}-nsg"
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_virtual_machine" "compute" {
  name                  = "${var.vm-name}-vm01"
  location            = var.location
  resource_group_name = var.rg
  network_interface_ids = [azurerm_network_interface.compute.id]
  vm_size               = "Standard_B2s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm-name}-osdisk"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "${var.vm-name}-vm01"
    admin_username = "testadmin"
    admin_password = var.admin_password
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
}