variable "name" {
  type = string
}
variable "network_interface_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "ip_configuration_name" {
  type = string
}
variable "virtual_network_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "size" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type = string
}
variable "caching" {
  type = string
}
variable "storage_account_type" {
  type = string
}
variable "publisher" {
  type = string
}
variable "offer" {
  type = string
}
variable "sku" {
  type = string
}
variable "version" {
  type = string
}

variable "private_ip_address_allocation" {
  type = string
}
variable "address_space" {
  type = list
}
variable "address_prefix" {
  type = list
}
variable "create_virtualmachine" {
  type = bool
}