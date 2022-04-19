module "resource_group" {
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  version                 = "0.0.1"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  tag_map                 = var.rg_tags
  lock_level_value        = var.lock_level_value
}

module "vnet" {
  source                      = "OT-terraform-azure-modules/virtual-network/azure"
  version                     = "0.0.2"
  vnet_name                   = var.vnet_name
  resource_group_location     = module.resource_group.resource_group_location
  resource_group_name         = module.resource_group.resource_group_name
  address_space               = var.address_space
  tag_map                     = var.vnet_tags
  // create_ddos_protection_plan = var.create_ddos_protection_plan
  dns_servers                 = var.dns_servers
}

module "subnet" {
  source                  = "git@gitlab.com:ot-azure/terraform/subnet.git?ref=kritarth"
  subnet_address_prefixes = var.subnet_address_prefixes
  subnet_name             = var.subnet_name
  resource_group_name     = module.resource_group.resource_group_name
  vnet_name               = module.vnet.vnet_name
  service_endpoints       = var.subnet_service_endpoints
}

resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "vm" {
  source                           = "git@gitlab.com:ot-azure/terraform/virtual_machine.git?ref=VM_1.0.0"
  count                            = length(var.availability_zones)
  nic_ip_configuration_subnet_id   = module.subnet.subnet_id[count.index]
  name                             = var.vm_name[count.index]
  resource_group_name              = module.resource_group.resource_group_name
  location                         = var.vm_location
  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  delete_data_disks_on_termination = var.delete_data_disks_on_termination
  vm_size                          = var.vm_size
  zones                            = var.availability_zones[count.index]
  os_profile_linux_config = {
    disable_password_authentication = true
    ssh_keys = {
      key_data = tls_private_key.vm_key.public_key_openssh
      path     = "/home/mehul/.ssh/authorized_keys"
    }
  }
  storage_image_reference = var.storage_image_reference
  storage_os_disk = {
    name          = var.vm_name[count.index]
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
  }
  os_profile = var.os_profile
  tagMap = {
    Name = var.vm_name[count.index]
  }
  depends_on = [tls_private_key.vm_key]
}

