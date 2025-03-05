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

### Log Analytics Workspace
variable "la_workspace_name" {
  type        = string
  description = "(Required) Log Analytics Workspace name"
}

