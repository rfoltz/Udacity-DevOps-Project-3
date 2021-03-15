output "subnet_id" {
  value = azurerm_subnet.test.id
}

output "subnet_address_prefixes" {
  value = azurerm_subnet.test.address_prefixes
}
