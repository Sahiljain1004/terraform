resource "azurerm_windows_web_app" "webapp" {
  count = "${var.create_webapp == true ? 1 : 0 }"
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.example[0].id

  site_config {}
}