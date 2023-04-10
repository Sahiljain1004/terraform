resource "azurerm_availability_set" "appset" {
  name                = "app-set"
  location            = local.location
  resource_group_name = local.resource_group_name
  platform_fault_domain_count = 2
  platform_update_domain_count = 2  
}