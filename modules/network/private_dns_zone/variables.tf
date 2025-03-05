### Common variables
variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name"
}

### Private DNS Zone Variables
variable "name" {
  type        = string
  description = "(Required) Private DNS Zone name"
}

variable "tags" {
  type        = map(string)
  description = "(Required) A map of tags to assign to the resources."
}