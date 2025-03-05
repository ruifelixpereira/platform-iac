# Subnet resource
locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")

}

# Create Route Table
resource "azurerm_route_table" "rt" {
  name                          = "${var.name}-${lower(var.environment)}-rt-${local.location_short}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled

  tags = var.tags


  lifecycle {
    # Prevent accidental destruction
    ignore_changes = [
      name
    ]

    precondition {
      condition     = local.location_short != "unknown"
      error_message = "Ensure that location is a valid Azure region"
    }
  }
}

# Create routes associated to the Route Table
resource "azurerm_route" "rt" {
  for_each = {
    for route in var.routes :
    route.name => route # Iterate over route name since it is unique
  }

  name                = each.value.name
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.rt.name

  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address
}