provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}
# This is where the terraform state is held in the storage account
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "tstate6853"
    container_name       = "tstate"
    key                  = "" # use terraform init -backend-config "key=PASTE YOUR KEY HERE or Use an enviroment variable"
  }
}

# start the module building
module "resource_group" {
    source               = "../../modules/resource_group"
    resource_group       = "${var.prefix}-rg" # personally this is how I like to have my stuff with pre-defined tags on the end for consistentcy
    location             = var.location
}
module "virtual_network" {
  source                 = "../../modules/networking/virtualnetwork"
  prefix                 = var.prefix
  resource_group         = module.resource_group.resource_group_name # Use the name that was output by the resource group module
  location               = var.location
}