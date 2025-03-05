# Firewall policy rule collection group
module "firewall_rule_collection_group" {
  source                                                            = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
  firewall_policy_rule_collection_group_firewall_policy_id          = var.firewall_policy_resource_id
  firewall_policy_rule_collection_group_name                        = var.rule_collection_group_name
  firewall_policy_rule_collection_group_priority                    = var.rule_collection_group_priority
  firewall_policy_rule_collection_group_network_rule_collection     = var.firewall_policy_rule_collection_group_network_rule_collection
  firewall_policy_rule_collection_group_application_rule_collection = var.firewall_policy_rule_collection_group_application_rule_collection
}
