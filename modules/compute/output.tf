output vm_private_ip {
    value = azurerm_network_interface.compute.private_ip_address
}

output vm_id {
    value = azurerm_virtual_machine.compute.id
}

output nsg_name {
    value = azurerm_network_security_group.compute.name
}

output nsg_id {
    value = azurerm_network_security_group.compute.id
}

output nic_id {
    value = azurerm_network_interface.compute.id
}