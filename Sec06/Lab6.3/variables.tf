/*rg be-rg
vnet web-vnet
subnet web-subnet
nsg web-nsg
nic web-nic
vm web-vm01
rg fe-rg
pip pub-ip01
fw  fw-01
vnet fe-vnet
rg jbox-rg
vm jbox-vm01
nic jbox-nic
nsg jbox-nsg*/
# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards


variable be-rg-name {
  type    = string
  default = "Be-rg"
}
variable location-name {
  type    = string
  default = "westeurope"
}
variable web-vnet-name {
  type    = string
  default = "Web-vnet"
}
variable web-sub-name {
  type    = string
  default = "Web-subnet"
}
variable web-vm-name {
  type    = string
  default = "Web"
}
variable fe-rg-name {
  type    = string
  default = "Fe-rg"
}
variable fe-vnet-name {
  type    = string
  default = "Fe-vnet"
}
variable jb-sub-name {
  type    = string
  default = "Jbox-subnet"
}
variable pip-name {
  type    = string
  default = "Pub-ip01"
}
variable fw-name {
  type    = string
  default = "FW-01"
}
variable jb-rg-name {
  type    = string
  default = "Jbox-rg"
}
variable jb-vm-name {
  type    = string
  default = "Jbox"
}
variable admin_username {
  type    = string
  default = "testadmin"
}
variable admin_password {
  type    = string
  default = "Password1234!"
}