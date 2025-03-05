# Subnet resource
locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")

}

# Create Public IP
resource "azurerm_public_ip" "pip" {
  name                    = "${var.name}-${lower(var.environment)}-pip-${local.location_short}"
  allocation_method       = var.public_ip_configuration.allocation_method
  location                = var.location
  resource_group_name     = var.resource_group_name
  ddos_protection_mode    = var.public_ip_configuration.ddos_protection_mode
  ddos_protection_plan_id = var.public_ip_configuration.ddos_protection_plan_id
  domain_name_label       = var.public_ip_configuration.domain_name_label
  idle_timeout_in_minutes = var.public_ip_configuration.idle_timeout_in_minutes
  ip_version              = var.public_ip_configuration.ip_version
  sku                     = var.public_ip_configuration.sku
  sku_tier                = var.public_ip_configuration.sku_tier
  tags                    = var.tags
  zones                   = var.public_ip_configuration.zones

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

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

resource "azurerm_nat_gateway" "natgw" {
  location                = var.location
  name                    = "${var.name}-${lower(var.environment)}-ngw-${local.location_short}"
  resource_group_name     = var.resource_group_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  sku_name                = var.sku_name
  tags                    = var.tags
  zones                   = var.zones
}
