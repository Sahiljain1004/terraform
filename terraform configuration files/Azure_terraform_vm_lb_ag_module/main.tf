module "Virtual_Machines" {
  source                        = "./VirtualMachines"
  vm_names                      = ["1101sj","222sj"]
  private_ip_address_allocation = "Dynamic" //Static or Dynamic
  resource_group_name           = "sa1_test_eic_trainingSahil"
  location                      = "Southeast Asia"
  virtual_network_name          = "vnetbysahil"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_name                   = "subnetA"
  subnet_address_prefixes       = ["10.0.0.0/24"]
  size                          = "Standard_D2s_v3"
  admin_username                = "adminuser"
  admin_password                = "Azure@123"
  caching                       = "ReadWrite"
  storage_account_type          = "Standard_LRS"
  sku                           = "2019-Datacenter"
  //fill below details if you want to add network security group
  create_network_security_group = true
  network_security_group_name   = "nsgbysj"
  security_rule_name            = "AllowRDP"
  priority                      = 300
  direction                     = "Inbound"
  access                        = "Allow"
  protocol                      = "Tcp"
  destination_port_range        = "3389"
  //fill below details if you want to add application gateway
  create_appgateway             = true
  AppGateway_name               = "app-gateway"
  AppGateway_sku                = "Standard_v2"
  AG_subnet_name                = "appsubnet"  // We need an additional subnet in the virtual network
  AG_address_prefixes           = ["10.0.1.0/24"]
  //fill below details if you want to add loadbalancer
  create_loadbalancer           = false
  loadbalancer_name             = "app-balancer"
  loadbalancer_sku              = "Basic"
  pool_name                     = "poolA"
  probe_name                    = "probeA"
  rule_name                     = "ruleA"
//common details for app-gateway and loadbalancer
  public_ip_name                = "gateway-ip"
  allocation_method             = "Static" //Static or Dynamic
  public_ip_sku                 = "Standard" //type "Basic" for loadbalancer and "Standard" for app-gateway
}