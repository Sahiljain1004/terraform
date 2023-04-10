resource "azurerm_subnet" "subnet" {
  count = "${var.create_subnet == true ? 1 : 0 }"
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network[0].name
  address_prefixes     = var.address_prefixes
}