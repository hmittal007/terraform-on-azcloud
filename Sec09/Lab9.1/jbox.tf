resource "azurerm_resource_group" "jbox-rg" {
  name     = "${var.env}-Jbox-rg"
  location = var.location-name
}

module "jbox-vm" {
  source = "../../modules/compute"
  vm-name = "${var.env}-Jbox"
  subnet_id = module.fe-vnet.vnet_subnets[1]
  location = azurerm_resource_group.jbox-rg.location
  rg = azurerm_resource_group.jbox-rg.name
  admin_password = data.azurerm_key_vault_secret.kv01.value
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
  destination_address_prefix  = "${module.jbox-vm.vm_private_ip}/32"
  resource_group_name         = azurerm_resource_group.jbox-rg.name
  network_security_group_name = module.jbox-vm.nsg_name
}

resource "azurerm_network_interface_security_group_association" "jbox-rg" {
  network_interface_id      = module.jbox-vm.nic_id
  network_security_group_id = module.jbox-vm.nsg_id
}