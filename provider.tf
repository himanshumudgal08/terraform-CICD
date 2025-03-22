provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}
