locals {
  location_short = lookup({
    "northeurope" = "ne"
    "westeurope"  = "we"
  }, var.location, "unknown")
  tags = {
    environment = var.environment
  }
}

# Firewall policy rule collection group
module "rule_collection_group" {
  source                                                   = "../../modules/network/firewall-rule-collection"
  environment = var.environment
  location = var.location
  firewall_policy_resource_id = var.firewall_policy_resource_id
  rule_collection_group_name = var.rule_collection_group_name
  rule_collection_group_priority = var.rule_collection_group_priority
  
  firewall_policy_rule_collection_group_network_rule_collection = [
    {
      action   = "Allow"
      name     = "NetworkRuleCollection"
      priority = 400
      rule = [{
        name                  = "OutboundToInternet"
        description           = "Allow traffic outbound to the Internet"
        destination_addresses = ["*"]
        destination_ports     = ["443", "80"]
        source_addresses      = ["*"]
        protocols             = ["TCP"]
        },
        {
          name                  = "apiudp"
          rule_type             = "NetworkRule"
          protocols             = ["UDP"]
          source_addresses      = ["*"]
          destination_addresses = ["AzureCloud.*"]
          destination_ports     = ["1194"]
        },
        {
          name                  = "apitcp"
          rule_type             = "NetworkRule"
          protocols             = ["TCP"]
          source_addresses      = ["*"]
          destination_addresses = ["AzureCloud.*"]
          destination_ports     = ["9000"]
        },
        {
          name              = "time"
          rule_type         = "NetworkRule"
          protocols         = ["UDP"]
          source_addresses  = ["*"]
          destination_fqdns = ["ntp.ubuntu.com"]
          destination_ports = ["123"]
        },
        {
          name              = "ghcr"
          rule_type         = "NetworkRule"
          protocols         = ["TCP"]
          source_addresses  = ["*"]
          destination_fqdns = ["ghcr.io", "pkg-containers.githubusercontent.com"]
          destination_ports = ["443"]
        },
        {
          name              = "docker"
          rule_type         = "NetworkRule"
          protocols         = ["TCP"]
          source_addresses  = ["*"]
          destination_fqdns = ["docker.io", "registry-1.docker.io", "production.cloudflare.docker.com"]
          destination_ports = ["443"]
        }
      ]
    }
  ]
  firewall_policy_rule_collection_group_application_rule_collection = [
    {
      action   = "Allow"
      name     = "ApplicationRuleCollection"
      priority = 600
      rule = [
        {
          name             = "AllowAll"
          description      = "Allow traffic to Microsoft.com"
          source_addresses = ["10.1.0.0/16"]
          protocols = [
            {
              port = 443
              type = "Https"
            }
          ]
          destination_fqdns = ["microsoft.com"]
        },
        {
          name             = "egress"
          description      = "AKS egress Traffic"
          source_addresses = ["10.1.1.0/24"]
          protocols = [
            {
              port = 443
              type = "Https"
            }
          ]
          destination_fqdns = ["*.azmk8s.io",
            "aksrepos.azurecr.io",
            "*.blob.core.windows.net",
            "*.cdn.mscr.io",
            "*.opinsights.azure.com",
          "*.monitoring.azure.com"]
        },
        {
          name             = "Registries"
          description      = "ACR Traffic"
          source_addresses = ["10.1.1.0/24"]
          protocols = [
            {
              port = 443
              type = "Https"
            }
          ]
          destination_fqdns = ["*.azurecr.io",
            "*.gcr.io",
            "*.docker.io",
            "quay.io",
            "*.quay.io",
            "*.cloudfront.net",
          "production.cloudflare.docker.com"]
        },
        {
          name             = "aksfwar"
          description      = "AKS Service Tag"
          source_addresses = ["10.1.1.0/24"]
          protocols = [
            { port = 80
              type = "Http"
            },
            { port = 443
              type = "Https"
          }]
          destination_fqdn_tags = ["AzureKubernetesService"]
        }
      ]
    }
  ]
}
