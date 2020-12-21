output "fw_public_ip" {
    value = azurerm_public_ip.fe-rg.ip_address
}

//terraform v14
output "vm-password" {
    value = var.admin_password
    sensitive = true #terraform v14
}