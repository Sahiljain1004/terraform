resource "azurerm_network_interface" "interface" {
  for_each = toset(local.function)
  name                = "${each.key}-interface"
  location            = local.location  
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = var.private_ip_address_allocation    
  }

}


resource "azurerm_windows_virtual_machine" "vm" {
  for_each = toset(local.function)
  name                = "${each.key}vm"
  resource_group_name = local.resource_group_name
  location            = local.location 
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.appset.id      
    network_interface_ids = [
    azurerm_network_interface.interface[each.key].id,
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.sku
    version   = "latest"
  }
 
}