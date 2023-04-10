variable "app_service_plan_name" {
    type = string
    description = "Azure RM service plan"
}

variable "functionapp_name" {
  type = string
}

variable "webapp_name" {
  type = string
}
variable "storage_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
  description = "Resource Group Name"
}

variable "location" {
  type = string
  description = "location of resource group"
}
variable "create_appserviceplan" {
  type = bool
}
variable "create_functionapp" {
  type = bool
}
variable "create_webapp" {
  type = bool
}