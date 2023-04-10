resource "azurerm_storage_account" "example" {
  count = "${var.create_functionapp == true ? 1 : 0 }"
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_windows_function_app" "functionapp" {
  count = "${var.create_functionapp == true ? 1 : 0 }"
  name                = var.functionapp_name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.example[0].name
  storage_account_access_key = azurerm_storage_account.example[0].primary_access_key
  service_plan_id            = azurerm_service_plan.example[0].id

  site_config {}
}