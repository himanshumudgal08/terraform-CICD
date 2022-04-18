 provider "azurerm" {
   features {
     resource_group {
       prevent_deletion_if_contains_resources = false
     }
   }
}


// terraform {
//   required_providers {
//     azurerm = {
//       source  = "hashicorp/azurerm"
//       version = ">=3.0.0"
//     }
//   }
// }

// # Configure the Microsoft Azure Provider
// provider "azurerm" {
//   features {}
// }


module "res_group" {
  source                  = "git::git@gitlab.com:ot-azure/terraform/rg.git?ref=v1.1.0"
  // source                  = "OT-terraform-azure-modules/resource-group/azure"
  // version                 = "0.0.1"
  resource_group_name     = "test-demo01"
  resource_group_location = var.location
  lock_level_value        = ""
  tag_map = {
   Name = "Demo-rg"
   Env = "dev"
}
}
module "vnet" {
  source                      = "git::git@gitlab.com:ot-azure/terraform/virtual_network.git?ref=v1.1.0"
  // source                      = "OT-terraform-azure-modules/virtual-network/azure"
  // version                     = "0.0.2"
  resource_group_name         = module.res_group.resource_group_name
  resource_group_location     = var.location
  address_space               = ["10.0.0.0/16"]
  vnet_name                   = "test-vnet"
  dns_servers                 = ["10.0.0.4", "10.0.0.5"]
  create_ddos_protection_plan = false
  tag_map = {
    Name = "test vnet"
Env = "dev"
  }
}

module "subnet_module" {
  source                  = "git::git@gitlab.com:ot-azure/terraform/subnet.git?ref=kritarth"
  // source                  = "OT-terraform-azure-modules/subnet/azure"
  // version                 = "0.0.2"
  resource_group_name     = module.res_group.resource_group_name
  vnet_name               = module.vnet.vnet_name
  create_delegation       = false
  subnet_name             = ["opensource1"]
  subnet_address_prefixes = ["10.0.0.0/24"]
  service_endpoints       = ["Microsoft.AzureActiveDirectory"]
}



module "vm_module" {
  source                         = "../"
  nic_ip_configuration_subnet_id = module.subnet_module.subnet_id[0]
  name                           = var.test_vm_name
  resource_group_name            = module.res_group.resource_group_name
  location                       = var.location
  vm_size                        = var.test_vm_size
  storage_image_reference        = var.test_vm_storage_image_reference
  storage_os_disk                = var.test_vm_storage_os_disk
  os_profile                     = var.test_vm_os_profile
  os_profile_linux_config        = var.test_vm_os_profile_linux_config
}

output "subnetid_0" {
  value = module.subnet_module.subnet_id[0]

}
