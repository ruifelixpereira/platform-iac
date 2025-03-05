# Network Resource Group
resource "azurerm_resource_group" "network_rg" {
  location = var.location
  name     = var.network_resource_group_name
  tags     = {
    environment = var.environment
  }
}

# Virtual WAN with Virtual Hub + ER Gateway + Firewall
module "virtual_wan_ergw_fw" {
  source              = "../../modules/network/virtual-wan"
  location            = var.location
  environment         = var.environment
  resource_group_name = azurerm_resource_group.network_rg.name
  virtual_wan_name    = var.virtual_wan_name
  virtual_hub_address_prefix = var.virtual_hub_address_prefix
}

# Management Resource Group
resource "azurerm_resource_group" "management_rg" {
  location = var.location
  name     = var.management_resource_group_name
  tags     = {
    environment = var.environment
  }
}

module "mng_log_analytics" {
  source              = "../../modules/management/log-analytics"
  location            = var.location
  environment         = var.environment
  resource_group_name = azurerm_resource_group.management_rg.name
  la_workspace_name   = var.la_workspace_name
}