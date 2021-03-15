resource "azurerm_network_security_group" "test" {
  name                = "${var.prefix}-nsg"
  location            = var.location
  resource_group_name = var.resource_group


  security_rule {
    name                       = "PORT-5000"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5000"
    source_address_prefixes    = var.subnet_address_prefixes
    destination_address_prefix = "*"
  }
  
  security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
resource "azurerm_subnet_network_security_group_association" "test" {
    subnet_id                 = var.subnet_id
    network_security_group_id = azurerm_network_security_group.test.id
}