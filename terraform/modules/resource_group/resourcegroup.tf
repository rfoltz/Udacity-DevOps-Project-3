resource "azurerm_resource_group" "test" {
  name     = "${var.resource_group}-rg"
  location = var.location
}