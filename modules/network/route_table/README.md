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
| [azurerm_route.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_route_propagation_enabled"></a> [bgp\_route\_propagation\_enabled](#input\_bgp\_route\_propagation\_enabled) | (Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment Name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Region to which resources are created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Route Table name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | (Requried) List of routes. | <pre>list(object({<br/>    name                   = string                 # The name of the route.<br/>    address_prefix         = string                 # The destination CIDR to which the route applies.<br/>    next_hop_type          = string                 # Possible values: VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.<br/>    next_hop_in_ip_address = optional(string, null) #Next hop values are only allowed in routes where the next hop type is VirtualAppliance.<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A map of tags to assign to the resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Route Table ID |
<!-- END_TF_DOCS -->