variable "env" {
  type    = string
  default = "mgmt"
}
variable "location-name" {
  type    = string
  default = "westeurope"
}
variable "admin_password" {
  type      = string
  default   = "Password1234!"
  sensitive = true # example for terraform v14
}

variable "access-from" {
  default = "195.213.36.139"
}
