### Common variables

variable "location" {
  type        = string
  description = "(Required) Region to which resources are created"
}

variable "environment" {
  type        = string
  description = "(Required) Environment Name"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name"
}

variable "tags" {
  type        = map(string)
  description = "(Required) A map of tags to assign to the resources."
}

### Nat Gateway Variables
variable "name" {
  type        = string
  description = "(Required) Nat Gateway name"
}

variable "sku_name" {
  type        = string
  default     = null
  description = "(Optional) The SKU which should be used. At this time the only supported value is `Standard`. Defaults to `Standard`."
}

variable "idle_timeout_in_minutes" {
  type        = number
  default     = 30
  description = "(Optional) The idle timeout which should be used in minutes."
}

variable "zones" {
  type        = list(string)
  default     = ["1"]
  description = "(Optional) A list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created."
}

variable "public_ip_configuration" {
  type = object({
    allocation_method       = optional(string, "Static")
    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    idle_timeout_in_minutes = optional(number, 30)
    ip_version              = optional(string, "IPv4")
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    tags                    = optional(map(string), null)
    zones                   = optional(list(string), ["1", "2", "3"])
  })
  default = {
    allocation_method       = "Static"
    ddos_protection_mode    = "VirtualNetworkInherited"
    idle_timeout_in_minutes = 30
    ip_version              = "IPv4"
    sku_tier                = "Regional"
    sku                     = "Standard"
    zones                   = ["1", "2", "3"]
  }
  description = <<PUBLIC_IP_CONFIGURATION_DETAILS
This object describes the public IP configuration when creating Nat Gateway's with a public IP.  If creating more than one public IP, then these values will be used for all public IPs.

- `allocation_method`       = (Required) - Defines the allocation method for this IP address. Possible values are Static or Dynamic.
- `ddos_protection_mode`    = (Optional) - The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
- `ddos_protection_plan_id` = (Optional) - The ID of DDoS protection plan associated with the public IP. ddos_protection_plan_id can only be set when ddos_protection_mode is Enabled
- `domain_name_label`       = (Optional) - Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
- `idle_timeout_in_minutes` = (Optional) - Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
- `ip_version`              = (Optional) - The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created. Only static IP address allocation is supported for IPv6.
- `sku`                     = (Optional) - The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard to support zones by default. Changing this forces a new resource to be created. When sku_tier is set to Global, sku must be set to Standard.
- `sku_tier`                = (Optional) - The SKU tier of the Public IP. Accepted values are Global and Regional. Defaults to Regional
- `tags`                    = (Optional) - A mapping of tags to assign to the resource.    
- `zones`                   = (Optional) - A list of zones where this public IP should be deployed. Defaults to 3 zones. If your region doesn't support zones, then you'll need to set this to null.
  
  Example Inputs:

```hcl
#Standard Regional IPV4 Public IP address configuration
public_ip_configuration_details = {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  idle_timeout_in_minutes = 30
  ip_version              = "IPv4"
  sku_tier                = "Regional"
  sku                     = "Standard"
}
```
PUBLIC_IP_CONFIGURATION_DETAILS
  nullable    = false
}