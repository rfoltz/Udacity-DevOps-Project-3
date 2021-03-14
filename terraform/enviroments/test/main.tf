provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
# This is where the terraform state is held in the storage account
terraform {
  backend "azurerm" {
    resource_group_name  = "${var.resource_group}"
    storage_account_name = ""
    container_name       = "tstate"
    key                  = ""
  }
}