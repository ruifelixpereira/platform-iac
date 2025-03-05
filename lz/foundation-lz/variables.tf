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

### Network Variables
variable "network_resource_group_name" {
  type        = string
  description = "(Required) Resource group name for networking services"
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

### Management Variables
variable "management_resource_group_name" {
  type        = string
  description = "(Required) Resource group name for management services"
}

### Log Analytics Workspace
variable "la_workspace_name" {
  type        = string
  description = "(Required) Log Analytics Workspace name"
}