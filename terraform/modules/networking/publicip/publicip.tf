resource "azurerm_public_ip" "test" {
  name                = "${var.prefix}-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
}