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
 module "ResourceGroup" {
    source = "./ResourceGroup"
    base_name = "TerraformExample101"
    location = "West US"
 }

 module "StorageAccount" {
    source = "./StorageAccount"
    base_name = "TerraformExample101"
    resource_group_name = module.ResourceGroup.rg_name_out
    location = "West US"
   
 }