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

### Subnet Variables

variable "subnet_list" {
  description = "(Requried) List of subnets and their configs."
  type = list(object({
    name                    = string
    address_prefixes        = list(string)
    service_endpoints       = optional(list(string), [])
    nat_gateway_association = optional(bool, false)
    # list NSG rules
    security_rules = list(object({
      name                         = string,
      description                  = string,
      priority                     = number,
      direction                    = string,
      access                       = string,
      protocol                     = string,
      source_port_range            = optional(string, null),
      source_port_ranges           = optional(list(string), null),
      destination_port_range       = optional(string, null),
      destination_port_ranges      = optional(list(string), null),
      source_address_prefix        = optional(string, null),
      source_address_prefixes      = optional(list(string), null),
      destination_address_prefix   = optional(string, null),
      destination_address_prefixes = optional(list(string), null),
    }))
  }))
  default = []
}

variable "vnet_name" {
  type        = string
  description = "(Required) Parent VNET name"
}

variable "route_table_id" {
  type        = string
  description = "(Required) Route Table ID"
}

variable "nat_gateway_id" {
  type        = string
  description = "(Optional) NAT Gateway ID"
  default     = null
}