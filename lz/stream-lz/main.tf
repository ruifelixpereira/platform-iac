locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")
  tags = {
    environment = var.environment
  }
}

# Network Resource Group
resource "azurerm_resource_group" "network_rg" {
  location = var.location
  name     = var.network_resource_group_name
  tags     = local.tags
}

# Virtual Network
module "stream_vnet" {
  source              = "../../modules/network/virtual_network"
 
  for_each = var.virtual_networks != null ? var.virtual_networks : {}

  location            = var.location
  environment         = var.environment
  name                = each.value.name
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = [each.value.address_space]
  tags                = local.tags
}

# Connect Virtual Network with Virtual Hub
resource "azurerm_virtual_hub_connection" "vhub_vnet_conn" {

  for_each = module.stream_vnet != null ? module.stream_vnet : {}

  name                      = "vhub-vnet-conn-${each.value.name}"
  virtual_hub_id            = var.virtual_hub_id
  remote_virtual_network_id = each.value.id
}