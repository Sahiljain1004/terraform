resource "azurerm_service_plan" "example" {
  count = "${var.create_appserviceplan == true ? 1 : 0 }"
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "B1"
  os_type             = "Windows"
}
