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
    key                  = "terraform.state"
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
module "security_group" {
  source                  = "../../modules/networking/securitygroup"
  prefix                  = var.prefix
  resource_group          = module.resource_group.resource_group_name
  location                = var.location
  subnet_id               = module.virtual_network.subnet_id
  subnet_address_prefixes = module.virtual_network.subnet_address_prefixes
}
module "app_service" {
  source                  = "../../modules/appservice"
  prefix                  = var.prefix
  resource_group          = module.resource_group.resource_group_name
  location                = var.location
}
module "publicip" {
  source                  = "../../modules/networking/publicip"
  prefix                  = var.prefix
  resource_group          = module.resource_group.resource_group_name
  location                = var.location
}
module "virtual_machine" {
  source                  = "../../modules/vm"
  prefix                  = var.prefix
  resource_group          = module.resource_group.resource_group_name
  location                = var.location
  public_ip_address_id    = module.publicip.public_ip_address_id
  subnet_id               = module.virtual_network.subnet_id
  vm_password             = var.vm_password
}