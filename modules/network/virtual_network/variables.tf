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

### VNET Variables
variable "name" {
  type        = string
  description = "(Required) VNET name"
}

variable "dns_servers" {
  type        = list(string)
  description = "(Optional) List of IP addresses of DNS servers"
  default     = null
}

variable "address_space" {
  type        = list(string)
  description = "(Required) List of IP address spaces for the VNET"
}

variable "tags" {
  type        = map(string)
  description = "(Required) A map of tags to assign to the resources."
}

variable "private_dns_zone_name" {
  type        = string
  description = "(Optional) Private DNS Zone name"
  default     = null
}