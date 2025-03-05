## VNET resource
locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")
}

# Create Private DNS Resolver
resource "azurerm_private_dns_resolver" "test" {
  name                = "${var.name}-${lower(var.environment)}-dnspr-${local.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = var.virtual_network_id

  tags = var.tags

  lifecycle {
    precondition {
      condition     = local.location_short != "unknown"
      error_message = "Ensure that location is a valid Azure region"
    }
  }
}