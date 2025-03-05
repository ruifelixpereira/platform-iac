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

### Firewall policy rule collection
variable "firewall_policy_resource_id" {
  type        = string
  description = "(Required) Firewall policy resource id to add this rule collection"
}

variable "rule_collection_group_name" {
  type        = string
  description = "(Required) Firewall policy rule collection group name"
  default = "NetworkRuleCollectionGroup"
}

variable "rule_collection_group_priority" {
  type        = number
  description = "(Required) Firewall policy rule collection group priority"
  default = 400
}

variable "firewall_policy_rule_collection_group_application_rule_collection" {
  type = list(object({
    action   = string
    name     = string
    priority = number
    rule = list(object({
      description           = optional(string)
      destination_addresses = optional(list(string), [])
      destination_fqdn_tags = optional(list(string), [])
      destination_fqdns     = optional(list(string), [])
      destination_urls      = optional(list(string), [])
      name                  = string
      source_addresses      = optional(list(string), [])
      source_ip_groups      = optional(list(string), [])
      terminate_tls         = optional(bool)
      web_categories        = optional(list(string), [])
      http_headers = optional(list(object({
        name  = string
        value = string
      })))
      protocols = optional(list(object({
        port = number
        type = string
      })))
    }))
  }))
  default     = null
  description = <<-EOT
- `action` - (Required) The action to take for the application rules in this collection. Possible values are `Allow` and `Deny`.
- `name` - (Required) The name which should be used for this application rule collection.
- `priority` - (Required) The priority of the application rule collection. The range is `100`

---
`rule` block supports the following:
- `description` -
- `destination_addresses` -
- `destination_fqdn_tags` -
- `destination_fqdns` -
- `destination_urls` -
- `name` - (Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created.
- `source_addresses` -
- `source_ip_groups` -
- `terminate_tls` -
- `web_categories` -

---
`http_headers` block supports the following:
- `name` - (Required) Specifies the name of the header.
- `value` - (Required) Specifies the value of the value.

---
`protocols` block supports the following:
- `port` - (Required) Port number of the protocol. Range is 0-64000.
- `type` - (Required) Protocol type. Possible values are `Http` and `Https`.
EOT
}

variable "firewall_policy_rule_collection_group_network_rule_collection" {
  type = list(object({
    action   = string
    name     = string
    priority = number
    rule = list(object({
      description           = optional(string)
      destination_addresses = optional(list(string), [])
      destination_fqdns     = optional(list(string), [])
      destination_ip_groups = optional(list(string), [])
      destination_ports     = list(string)
      name                  = string
      protocols             = list(string)
      source_addresses      = optional(list(string), [])
      source_ip_groups      = optional(list(string), [])
    }))
  }))
  default     = null
  description = <<-EOT
- `action` - (Required) The action to take for the network rules in this collection. Possible values are `Allow` and `Deny`.
- `name` - (Required) The name which should be used for this network rule collection.
- `priority` - (Required) The priority of the network rule collection. The range is `100`

---
`rule` block supports the following:
- `description` -
- `destination_addresses` -
- `destination_fqdns` -
- `destination_ip_groups` -
- `destination_ports` -
- `name` - (Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created.
- `protocols` -
- `source_addresses` -
- `source_ip_groups` -
EOT
}