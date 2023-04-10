
resource "azurerm_public_ip" "gatewayip" {
  count = "${var.create_appgateway == true ? 1 : 0 }"
  name                = var.public_ip_name
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = var.allocation_method 
  sku=var.public_ip_sku
}

# We need an additional subnet in the virtual network
resource "azurerm_subnet" "appsubnet" {
  count = "${var.create_appgateway == true ? 1 : 0 }"
  name                 = var.AG_subnet_name
  resource_group_name  = local.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.AG_address_prefixes 
  depends_on = [
      azurerm_virtual_network.appnetwork
    ]
}

resource "azurerm_application_gateway" "appgateway" {
  count = "${var.create_appgateway == true ? 1 : 0 }"
  name                = var.AppGateway_name
  resource_group_name = local.resource_group_name
  location            = local.location

  sku {
    name     = var.AppGateway_sku
    tier     = var.AppGateway_sku
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = azurerm_subnet.appsubnet[0].id
  }

  frontend_port {
    name = "front-end-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "front-end-ip-config"
    public_ip_address_id = azurerm_public_ip.gatewayip[0].id    
  }

  depends_on = [
    azurerm_public_ip.gatewayip,
    azurerm_subnet.appsubnet
  ]

   dynamic backend_address_pool {  
     for_each = toset(local.function)
     content {
      name  = "${backend_address_pool.value}-pool"
      ip_addresses = [
      "${azurerm_network_interface.interface[backend_address_pool.value].private_ip_address}"
      ]
    }
   }

      backend_http_settings {
    name                  = "HTTPSetting"
    cookie_based_affinity = "Disabled"
    path                  = ""
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

 http_listener {
    name                           = "gateway-listener"
    frontend_ip_configuration_name = "front-end-ip-config"
    frontend_port_name             = "front-end-port"
    protocol                       = "Http"
  }

request_routing_rule {
    name               = "RoutingRuleA"
    rule_type          = "PathBasedRouting"
    url_path_map_name  = "RoutingPath"
    http_listener_name = "gateway-listener"    
    priority = 1
  }
  
  url_path_map {
    name                               = "RoutingPath"    
    default_backend_address_pool_name   = "${local.function[0]}-pool"
    default_backend_http_settings_name  = "HTTPSetting"
   
     dynamic path_rule {
      for_each = toset(local.function)
       content {
      name                          = "${path_rule.value}RoutingRule"
      backend_address_pool_name     = "${path_rule.value}-pool"
      backend_http_settings_name    = "HTTPSetting"
      paths = [
        "/${path_rule.value}/*",
      ]
    }
     }
    
  }

}