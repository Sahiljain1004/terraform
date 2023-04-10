variable "vm_names" {
  type = list
}
variable "private_ip_address_allocation" {
  type = string
}

variable "resource_group_name" {
  type = string
}
variable "location" {
  type =  string
}
variable "virtual_network_address_space" {
  type = list
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
variable "sku" {
  type = string
}
variable "subnet_name" {
  type = string 
}
variable "virtual_network_name" {
  type = string
}
variable "subnet_address_prefixes" {
  type = list
}
variable "public_ip_name" {
type = string
}
variable "allocation_method" {
  type = string
}
variable "public_ip_sku" {
  type = string
}
variable "AG_subnet_name" {
  type = string
}
variable "AG_address_prefixes" {
  type = list
}
variable "AppGateway_name" {
  type = string
}
variable "AppGateway_sku" {
  type = string
}
variable "create_appgateway" {
    type = bool
}
variable "loadbalancer_name" {
  type = string
}
variable "loadbalancer_sku" {
  type = string
  
}
variable "rule_name" {
  type = string
}
variable "probe_name" {
  type = string
}
variable "pool_name" {
  type = string
}
variable "create_loadbalancer" {
    type = bool
}
variable "network_security_group_name" {
  type = string
}
variable "security_rule_name" {
  type = string
}
variable "priority" {
  type = number
}
variable "direction" {
  type = string
}
variable "access" {
  type = string
}
variable "protocol" {
  type = string
}
variable "destination_port_range" {
  type = string
}
variable "create_network_security_group" {
  type = bool
}