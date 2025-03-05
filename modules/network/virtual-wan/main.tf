locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")
  tags = {
    environment = var.environment
  }
}

# Firewall policy
module "firewall_policy" {
  source              = "Azure/avm-res-network-firewallpolicy/azurerm"
  version             = "0.3.3"
  name                = "azureFirewallPolicy"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  firewall_policy_dns = {
    proxy_enabled = true
  }
}

# Virtual WAN
module "vwan_with_vhub" {
  source  = "Azure/avm-ptn-virtualwan/azurerm"
  version = "0.9.0"
  resource_group_name            = var.resource_group_name
  location                       = var.location
  virtual_wan_name               = var.virtual_wan_name
  type                           = "Standard"
  virtual_wan_tags               = local.tags
  virtual_hubs = {
    ("${local.location_short}-vhub") = {
      name           = "vhub-vwan-${local.location_short}"
      location       = var.location
      resource_group = var.resource_group_name
      address_prefix = var.virtual_hub_address_prefix
      tags           = local.tags
    }
  }
  expressroute_gateways = {
    ("${local.location_short}-vhub-er-gw") = {
      name            = "er-gw-vwan-${local.location_short}"
      virtual_hub_key = "${local.location_short}-vhub"
      scale_units     = 1
      tags            = local.tags
    }
  }
  er_circuit_connections = {}
  firewalls = {
    ("${local.location_short}-vhub-fw") = {
      sku_name           = "AZFW_Hub"
      sku_tier           = "Standard"
      name               = "fw-vwan-${local.location_short}"
      virtual_hub_key    = "${local.location_short}-vhub"
      firewall_policy_id = module.firewall_policy.resource.id
      tags               = local.tags
    }
  }
  routing_intents = {
    "${local.location_short}-vhub-routing-intent" = {
      name            = "private-routing-intent"
      virtual_hub_key = "${local.location_short}-vhub"
      routing_policies = [{
        name                  = "${local.location_short}-vhub-routing-policy-private"
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = "${local.location_short}-vhub-fw"
      }]
    }
  }
}

