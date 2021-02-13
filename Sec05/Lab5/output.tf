# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards
output "fw_public_ip" {
    value = azurerm_public_ip.fe-rg.ip_address
}