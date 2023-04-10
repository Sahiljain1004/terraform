resource "azurerm_public_ip" "example" {
  count = "${var.createloadbalancer == true ? 1 : 0 }"
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
}

resource "azurerm_lb" "example" {
  count = "${var.createloadbalancer == true ? 1 : 0 }"
  name                = var.loadbalancer_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example[0].id
  }
}