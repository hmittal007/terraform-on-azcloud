output "fw_public_ip" {
    value = azurerm_public_ip.fe-rg.ip_address
}