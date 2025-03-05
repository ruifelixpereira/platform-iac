# aks
Manages a Managed Kubernetes Cluster (also known as AKS / Azure Kubernetes Service)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment Name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Region to which resources are created | `string` | n/a | yes |
| <a name="input_nat_gateway_id"></a> [nat\_gateway\_id](#input\_nat\_gateway\_id) | (Optional) NAT Gateway ID | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name | `string` | n/a | yes |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | (Required) Route Table ID | `string` | n/a | yes |
| <a name="input_subnet_list"></a> [subnet\_list](#input\_subnet\_list) | (Requried) List of subnets and their configs. | <pre>list(object({<br/>    name                    = string<br/>    address_prefixes        = list(string)<br/>    service_endpoints       = optional(list(string), [])<br/>    nat_gateway_association = optional(bool, false)<br/>    # list NSG rules<br/>    security_rules = list(object({<br/>      name                         = string,<br/>      description                  = string,<br/>      priority                     = number,<br/>      direction                    = string,<br/>      access                       = string,<br/>      protocol                     = string,<br/>      source_port_range            = optional(string, null),<br/>      source_port_ranges           = optional(list(string), null),<br/>      destination_port_range       = optional(string, null),<br/>      destination_port_ranges      = optional(list(string), null),<br/>      source_address_prefix        = optional(string, null),<br/>      source_address_prefixes      = optional(list(string), null),<br/>      destination_address_prefix   = optional(string, null),<br/>      destination_address_prefixes = optional(list(string), null),<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A map of tags to assign to the resources. | `map(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | (Required) Parent VNET name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet"></a> [subnet](#output\_subnet) | List of all Subnets created in the Virtual Network |
<!-- END_TF_DOCS -->