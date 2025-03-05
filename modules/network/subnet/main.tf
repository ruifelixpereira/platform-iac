# Subnet resource
locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")

  # Flatten subnet list for security rules
  security_rules = flatten([
    for subnet in var.subnet_list : [
      for security_rule in subnet.security_rules : {
        subnet_name                  = subnet.name
        name                         = security_rule.name
        description                  = security_rule.description
        priority                     = security_rule.priority
        direction                    = security_rule.direction
        access                       = security_rule.access
        protocol                     = security_rule.protocol
        source_port_range            = security_rule.source_port_range
        source_port_ranges           = security_rule.source_port_ranges
        destination_port_range       = security_rule.destination_port_range
        destination_port_ranges      = security_rule.destination_port_ranges
        source_address_prefix        = security_rule.source_address_prefix
        source_address_prefixes      = security_rule.source_address_prefixes
        destination_address_prefix   = security_rule.destination_address_prefix
        destination_address_prefixes = security_rule.destination_address_prefixes
      }
    ]
  ])
}

resource "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in var.subnet_list :
    subnet.name => subnet # Iterate over subnet name since it is unique
  }
  name                                          = "${each.value.name}-${lower(var.environment)}-snet-${local.location_short}"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.vnet_name
  address_prefixes                              = each.value.address_prefixes
  default_outbound_access_enabled               = false
  private_link_service_network_policies_enabled = false
  service_endpoints                             = each.value.service_endpoints

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

# Associate route table to the subnets
resource "azurerm_subnet_route_table_association" "this" {
  for_each = {
    for subnet in var.subnet_list :
    subnet.name => subnet # Iterate over subnet name since it is unique
  }

  route_table_id = var.route_table_id
  subnet_id      = azurerm_subnet.subnet[each.value.name].id
}

# Associate nat gateway to the subnets
resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = {
    for subnet in var.subnet_list :
    subnet.name => subnet                      # Iterate over subnet name since it is unique
    if subnet.nat_gateway_association != false # If nat_gateway_association is set to false, then the association is not created
  }

  nat_gateway_id = var.nat_gateway_id
  subnet_id      = azurerm_subnet.subnet[each.value.name].id
}

resource "azurerm_network_security_group" "nsg" {
  for_each = {
    for subnet in var.subnet_list :
    subnet.name => subnet # Iterate over subnet name since it is unique
  }
  name                = "${each.value.name}-${lower(var.environment)}-nsg-${local.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags

  lifecycle {
    precondition {
      condition     = local.location_short != "unknown"
      error_message = "Ensure that location is a valid Azure region"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  for_each = {
    for subnet in var.subnet_list :
    subnet.name => subnet # Iterate over subnet name since it is unique
  }
  subnet_id                 = azurerm_subnet.subnet[each.value.name].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.name].id
}

resource "azurerm_network_security_rule" "security_rule" {
  for_each = tomap({
    for security_rule in local.security_rules : "${security_rule.subnet_name}_${security_rule.name}" => security_rule
  })
  name                         = each.value.name
  description                  = each.value.description
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  source_port_ranges           = each.value.source_port_ranges
  destination_port_range       = each.value.destination_port_range
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefix        = each.value.source_address_prefix
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefix   = each.value.destination_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.nsg[each.value.subnet_name].name
}
