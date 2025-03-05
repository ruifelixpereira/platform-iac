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
| [azurerm_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment Name | `string` | n/a | yes |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | (Optional) The idle timeout which should be used in minutes. | `number` | `30` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Region to which resources are created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Nat Gateway name | `string` | n/a | yes |
| <a name="input_public_ip_configuration"></a> [public\_ip\_configuration](#input\_public\_ip\_configuration) | This object describes the public IP configuration when creating Nat Gateway's with a public IP.  If creating more than one public IP, then these values will be used for all public IPs.<br/><br/>- `allocation_method`       = (Required) - Defines the allocation method for this IP address. Possible values are Static or Dynamic.<br/>- `ddos_protection_mode`    = (Optional) - The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.<br/>- `ddos_protection_plan_id` = (Optional) - The ID of DDoS protection plan associated with the public IP. ddos\_protection\_plan\_id can only be set when ddos\_protection\_mode is Enabled<br/>- `domain_name_label`       = (Optional) - Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.<br/>- `idle_timeout_in_minutes` = (Optional) - Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.<br/>- `ip_version`              = (Optional) - The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created. Only static IP address allocation is supported for IPv6.<br/>- `sku`                     = (Optional) - The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard to support zones by default. Changing this forces a new resource to be created. When sku\_tier is set to Global, sku must be set to Standard.<br/>- `sku_tier`                = (Optional) - The SKU tier of the Public IP. Accepted values are Global and Regional. Defaults to Regional<br/>- `tags`                    = (Optional) - A mapping of tags to assign to the resource.<br/>- `zones`                   = (Optional) - A list of zones where this public IP should be deployed. Defaults to 3 zones. If your region doesn't support zones, then you'll need to set this to null.<br/><br/>  Example Inputs:<pre>hcl<br/>#Standard Regional IPV4 Public IP address configuration<br/>public_ip_configuration_details = {<br/>  allocation_method       = "Static"<br/>  ddos_protection_mode    = "VirtualNetworkInherited"<br/>  idle_timeout_in_minutes = 30<br/>  ip_version              = "IPv4"<br/>  sku_tier                = "Regional"<br/>  sku                     = "Standard"<br/>}</pre> | <pre>object({<br/>    allocation_method       = optional(string, "Static")<br/>    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")<br/>    ddos_protection_plan_id = optional(string)<br/>    domain_name_label       = optional(string)<br/>    idle_timeout_in_minutes = optional(number, 30)<br/>    ip_version              = optional(string, "IPv4")<br/>    sku                     = optional(string, "Standard")<br/>    sku_tier                = optional(string, "Regional")<br/>    tags                    = optional(map(string), null)<br/>    zones                   = optional(list(string), ["1", "2", "3"])<br/>  })</pre> | <pre>{<br/>  "allocation_method": "Static",<br/>  "ddos_protection_mode": "VirtualNetworkInherited",<br/>  "idle_timeout_in_minutes": 30,<br/>  "ip_version": "IPv4",<br/>  "sku": "Standard",<br/>  "sku_tier": "Regional",<br/>  "zones": [<br/>    "1",<br/>    "2",<br/>    "3"<br/>  ]<br/>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The SKU which should be used. At this time the only supported value is `Standard`. Defaults to `Standard`. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A map of tags to assign to the resources. | `map(string)` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) A list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created. | `list(string)` | <pre>[<br/>  "1"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Nat Gateway ID |
<!-- END_TF_DOCS -->