locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")
  tags = {
    environment = var.environment
  }
}

# Log Analytics workspace
module "log_analytics_workspace" {
  source             = "Azure/avm-res-operationalinsights-workspace/azurerm"
  location                                  = var.location
  resource_group_name                       = var.resource_group_name
  name                                      = var.la_workspace_name
  log_analytics_workspace_retention_in_days = 30
  log_analytics_workspace_sku               = "PerGB2018"
  log_analytics_workspace_identity = {
    type = "SystemAssigned"
  }
  tags = local.tags
}