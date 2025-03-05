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

### Virtual Network  Variables
variable "virtual_networks" {
  type = map(object({
    name          = string
    address_space = string
  }))
}

variable "virtual_hub_id" {
  type        = string
  description = "(Required) Virtual Hub ID where the stream VNet will be connected"
}
