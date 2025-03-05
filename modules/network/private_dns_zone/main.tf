## Private DNS Zone resource
resource "azurerm_private_dns_zone" "private_dns" {
  name                = var.name
  resource_group_name = var.resource_group_name

  tags = var.tags

  lifecycle {
    # Prevent accidental destruction
    ignore_changes = [
      name,
      resource_group_name
    ]
  }
}
