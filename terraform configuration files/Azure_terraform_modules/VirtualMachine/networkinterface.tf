resource "azurerm_network_interface" "network_interface" {
  count = "${var.create_networkinterface == true ? 1 : 0 }"
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}