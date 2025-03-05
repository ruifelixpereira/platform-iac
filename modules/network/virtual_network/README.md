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
| [azurerm_private_dns_zone_virtual_network_link.dns_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Required) List of IP address spaces for the VNET | `list(string)` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) List of IP addresses of DNS servers | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment Name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Region to which resources are created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) VNET name | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | (Optional) Private DNS Zone name | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A map of tags to assign to the resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The output value of the Vnet ID. |
| <a name="output_name"></a> [name](#output\_name) | The output value of the Vnet name. |
<!-- END_TF_DOCS -->