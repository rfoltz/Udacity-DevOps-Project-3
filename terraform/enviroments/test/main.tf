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
module "resource_group" {
    source               = "../../modules/resource_group"
    resource_group       = var.prefix
    location             = var.location
}