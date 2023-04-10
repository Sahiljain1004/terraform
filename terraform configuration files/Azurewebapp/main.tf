terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.34.0"
    }
  }
}

provider "azurerm" {
 features {
   
 }
}

module "AppServicePaln" {
source = "./AppServicePlan"
create_appserviceplan = false
create_functionapp = false
create_webapp = false
app_service_plan_name =  "appPlanBySahilJain"
resource_group_name = "sa1_test_eic_trainingSahil"
location = "Southeast Asia"
storage_account_name = "storeaccforfunappbySahil"
webapp_name = "webappBySahil"
functionapp_name = "functionappBySahil"
}


module "MySqlServer" {
  source                       = "./MySqlServer"
  create_mysqlserver = false
  create_appdb = false
  mmysqlserver_name = "mysqlserverbySahil"
  resource_group_name          = "sa1_test_eic_trainingSahil"
  location                     = "Southeast Asia"
  administrator_login          = "sqlserveradmin"
  administrator_login_password = "Sqladmin@1234"
  collation      = "SQL_Latin1_General_CP1_CI_AS" //fill this when you create appdb
  license_type   = "LicenseIncluded"              //fill this when you create appdb
  max_size_gb    = 2                              //fill this when you create appdb
  sku_name       = "Basics"                       //fill this when you create appdb
}


module "virtual_machine" {
  source                        = "./VirtualMachine"
  create_virtualmachine         = true
  name                          = "newwindowsvm1123581321"
  virtual_network_name          = "newvirtualnetworkbysahil"
  subnet_name                   = "subnetbysahil"
  network_interface_name        = "newnicbysahil"
  resource_group_name           = "sa1_test_eic_trainingSahil"
  address_space                 = ["10.0.0.0/16"]
  address_prefixes              = ["10.0.1.0/24"]
  ip_configuration_name         = "internal"
  private_ip_address_allocation = "Dynamic"
  location                      = "Southeast Asia"
  size                          = "Standard_F2"
  admin_username                = "sahiljain"
  admin_password                = "Sahiljain@5566"
  caching                       = "ReadWrite"
  storage_account_type          = "Standard_LRS"
  publisher                     = "MicrosoftWindowsServer"
  offer                         = "WindowsServer"
  sku                           = "2016-Datacenter"
}

module "LoadBalancer" {
  source = "./LoadBalancer"
  createloadbalancer = true
  public_ip_name = "PublicIPForLB"
  loadbalancer_name = "loadbalancerbysahil"
  frontend_ip_configuration_name = "PublicIPAddress"
  location = "Southeast Asia"
  resource_group_name           = "sa1_test_eic_trainingSahil"
  allocation_method = "Static"
}