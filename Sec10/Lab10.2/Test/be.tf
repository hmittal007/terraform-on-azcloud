resource "azurerm_resource_group" "be-rg" {
  name     = "${var.env}-Be-rg"
  location = var.location-name
}

module "be-vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name= "${var.env}-Web-vnet"
  resource_group_name = azurerm_resource_group.be-rg.name
  address_space       = ["10.0.2.0/23"]
  subnet_prefixes     = ["10.0.2.0/24"]
  subnet_names        = ["${var.env}-Web-subnet"]
  tags = null
}

module "web-vm" {
  source = "../../../modules/compute"
  vm-name = "${var.env}-Web"
  subnet_id = module.be-vnet.vnet_subnets[0]
  location = azurerm_resource_group.be-rg.location
  rg = azurerm_resource_group.be-rg.name
  admin_password = data.azurerm_key_vault_secret.kv01.value
}

resource "azurerm_network_security_rule" "be-rg" {
  name                        = "web"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "${module.web-vm.vm_private_ip}/32"
  resource_group_name         = azurerm_resource_group.be-rg.name
  network_security_group_name = module.web-vm.nsg_name
}

resource "azurerm_network_interface_security_group_association" "be-rg" {
  network_interface_id      = module.web-vm.nic_id
  network_security_group_id = module.web-vm.nsg_id
}

resource "azurerm_virtual_machine_extension" "be-rg" {
  name                 = "iis-extension"
  virtual_machine_id   = module.web-vm.vm_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings             = <<SETTINGS
    {
        "commandToExecute": "powershell Install-WindowsFeature -name Web-Server -IncludeManagementTools;"
    }
SETTINGS
}