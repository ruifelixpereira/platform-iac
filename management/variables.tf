### Common variables
variable "location" {
  type        = string
  description = "(Required) Region to which resources are created"
  default = "northeurope"
}

variable "environment" {
  type        = string
  description = "(Required) Environment Name"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name"
}

### Virtual Wan  Variables
variable "virtual_wan_name" {
  type        = string
  description = "(Required) Virtual WAN name"
}

variable "virtual_hub_address_prefix" {
  type        = string
  description = "(Required) Virtual Hub address prefix"
}
