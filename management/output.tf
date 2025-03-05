output "rg_vwan_name" {
  value = azurerm_resource_group.rg.name
}

output "vwan_resource_id" {
  value = module.vwan_with_vhub.resource.id
}

output "virtual_hub_resource_ids" {
  value = module.vwan_with_vhub.virtual_hub_resource_ids
}

output "firewall_private_ip_addresses" {
  value = module.vwan_with_vhub.firewall_private_ip_addresses
}

output "firewall_public_ip_addresses" {
  value = module.vwan_with_vhub.firewall_public_ip_addresses
}
