terraform {
  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = ">= 2.59.0"
    }
  }

  required_version = ">= 1.1.5"
}


terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}
