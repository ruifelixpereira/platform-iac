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

### Route Table Variables
variable "name" {
  type        = string
  description = "(Required) Route Table name"
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table."
  default     = true
}

variable "routes" {
  description = "(Requried) List of routes."
  type = list(object({
    name                   = string                 # The name of the route.
    address_prefix         = string                 # The destination CIDR to which the route applies.
    next_hop_type          = string                 # Possible values: VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
    next_hop_in_ip_address = optional(string, null) #Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
  }))
  default = []
}
