variable "mysqlserver_name" {
    type = string
}
variable "appdb_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "version" {
  type = string
}

variable "administrator_login" {
  type = string
}
variable "administrator_login_password" {
  type = string
}
variable "create_mysqlserver" {
  type = bool
}

variable "collation" {
  type = string
}
variable "license_type" {
  type = string
}

variable "max_size_gb" {
  type = number
}

variable "sku_name" {
  type = string
}

variable "create_appdb" {
  type = bool
}