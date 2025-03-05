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
variable "virtual_network_name" {
  type        = string
  description = "(Required) Virtual Network name"
}

variable "virtual_network_address_space" {
  type        = string
  description = "(Required) Virtual Hub address space CIDR"
}

variable "virtual_hub_id" {
  type        = string
  description = "(Required) Virtual Hub ID where the stream VNet will be connected"
}