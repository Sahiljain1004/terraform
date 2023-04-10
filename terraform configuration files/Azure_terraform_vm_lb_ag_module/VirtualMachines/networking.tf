resource "azurerm_virtual_network" "appnetwork" {
  name                = var.virtual_network_name
  location            = local.location  
  resource_group_name = local.resource_group_name
  address_space       = var.virtual_network_address_space
 
} 


resource "azurerm_subnet" "subnetA" {    
    name                 = var.subnet_name
    resource_group_name  = local.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes     = var.subnet_address_prefixes
    depends_on = [
      azurerm_virtual_network.appnetwork
    ]
}

resource "azurerm_network_security_group" "appnsg" {
  count = "${var.create_network_security_group == true ? 1 : 0 }"
  name                = var.network_security_group_name
  location            = local.location 
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = var.security_rule_name
    priority                   = var.priority
    direction                  = var.direction
    access                     = var.access
    protocol                   = var.protocol
    source_port_range          = "*"
    destination_port_range     = var.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

resource "azurerm_subnet_network_security_group_association" "appnsg-link" {  
  count = "${var.create_network_security_group == true ? 1 : 0 }"
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.appnsg[0].id

  depends_on = [
    azurerm_virtual_network.appnetwork,
    azurerm_network_security_group.appnsg
  ]
}

