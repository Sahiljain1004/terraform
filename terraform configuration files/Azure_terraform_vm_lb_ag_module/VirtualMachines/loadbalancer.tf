
resource "azurerm_public_ip" "loadip" {
  count = "${var.create_loadbalancer == true ? 1 : 0 }"
  name                = var.public_ip_name
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku             
}

resource "azurerm_lb" "appbalancer" {
    count = "${var.create_loadbalancer == true ? 1 : 0 }"
  name                = var.loadbalancer_name
  location            = local.location
  resource_group_name = local.resource_group_name
  sku = var.loadbalancer_sku
  sku_tier = "Regional"
  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.loadip[0].id
  }
  depends_on = [
    azurerm_public_ip.loadip
  ]
}

resource "azurerm_lb_backend_address_pool" "poolA" {
    count = "${var.create_loadbalancer == true ? 1 : 0 }"
  loadbalancer_id = azurerm_lb.appbalancer[0].id
  name            = var.pool_name
  depends_on = [
    azurerm_lb.appbalancer
  ]
}


resource "azurerm_lb_probe" "probeA" {
    count = "${var.create_loadbalancer == true ? 1 : 0 }"
  loadbalancer_id = azurerm_lb.appbalancer[0].id
  name            = var.probe_name
  port            = 80
  protocol = "Tcp"
  depends_on = [
    azurerm_lb.appbalancer
  ]
}

resource "azurerm_lb_rule" "RuleA" {
    count = "${var.create_loadbalancer == true ? 1 : 0 }"
  loadbalancer_id                = azurerm_lb.appbalancer[0].id
  name                           = var.rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  probe_id = azurerm_lb_probe.probeA[0].id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.poolA[0].id]
  depends_on = [
    azurerm_lb.appbalancer
  ]
}