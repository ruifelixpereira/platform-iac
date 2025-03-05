### Module outputs
output "id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The output value of the Vnet ID."
}

output "name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The output value of the Vnet name."
}