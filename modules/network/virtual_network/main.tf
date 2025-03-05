## VNET resource
locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")
}

# Create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-${lower(var.environment)}-vnet-${local.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = var.tags

  lifecycle {
    # Prevent accidental destruction
    ignore_changes = [
      name,
      location,
      resource_group_name
    ]

    precondition {
      condition     = local.location_short != "unknown"
      error_message = "Ensure that location is a valid Azure region"
    }
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  count                 = var.private_dns_zone_name != null ? 1 : 0
  name                  = "${var.name}-${lower(var.environment)}-vnetl-${local.location_short}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  tags = var.tags
}
