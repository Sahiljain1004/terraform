resource "azurerm_mssql_database" "appdb" {
  count = "${var.create_appdb == true ? 1 : 0 }"
  name           = var.appdb_name
  server_id      = azurerm_mssql_server.mssqlserver.id
  collation      = var.collation
  license_type   = var.license_type
  max_size_gb    = var.max_size_gb
  sku_name       = var.sku_name
}