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
| [azurerm_private_dns_resolver.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment Name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Region to which resources are created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) VNET name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A map of tags to assign to the resources. | `map(string)` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | (Required) The ID of the Virtual Network that is linked to the Private DNS Resolver. Changing this forces a new Private DNS Resolver to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The output value of the Vnet ID. |
| <a name="output_name"></a> [name](#output\_name) | The output value of the Vnet name. |
<!-- END_TF_DOCS -->