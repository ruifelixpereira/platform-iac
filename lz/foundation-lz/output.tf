output "rg_vwan_name" {
  value = azurerm_resource_group.network_rg.name
}

output "vwan_resource_id" {
  value = module.virtual_wan_ergw_fw.vwan_resource_id
}

output "virtual_hub_resource_ids" {
  value = module.virtual_wan_ergw_fw.virtual_hub_resource_ids
}

output "firewall_private_ip_addresses" {
  value = module.virtual_wan_ergw_fw.firewall_private_ip_addresses
}

output "firewall_public_ip_addresses" {
  value = module.virtual_wan_ergw_fw.firewall_public_ip_addresses
}

output "firewall_policy_resource_id" {
  value = module.virtual_wan_ergw_fw.firewall_policy_resource_id
}