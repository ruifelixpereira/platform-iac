terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.17.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.2.0"
    }

  }
  required_version = "~> 1.10.0"
}