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

### DNS Private Resolver Variables
variable "name" {
  type        = string
  description = "(Required) VNET name"
}

variable "virtual_network_id" {
  type        = string
  description = "(Required) The ID of the Virtual Network that is linked to the Private DNS Resolver. Changing this forces a new Private DNS Resolver to be created."
}

variable "tags" {
  type        = map(string)
  description = "(Required) A map of tags to assign to the resources."
}