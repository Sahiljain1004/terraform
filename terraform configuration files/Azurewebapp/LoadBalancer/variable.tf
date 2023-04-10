variable "public_ip_name" {
  type = string
}
variable "loadbalancer_name" {
  type = string
}
variable "frontend_ip_configuration_name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "allocation_method" {
  type = string
}
variable "createloadbalancer" {
  type = bool
}