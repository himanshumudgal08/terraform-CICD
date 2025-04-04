/*-------------------- Variable values for Resource Group ---------------------------------------*/

resource_group_name     = "rg-himanshuPoC"
resource_group_location = "Australia East"
rg_tags = {
  Name        = "rg-investcorp",
  Environment = "staging",
  Owner       = "DevOps"
}

/*-------------------- Variable values for Vnet ------------------------------------------------*/

vnet_name                   = "vnet-himanshuPoC"
address_space               = ["10.0.0.0/16"]
dns_servers                 = []
vnet_tags = {
  Name        = "vnet-investcorp-CI",
  Environment = "staging",
  Owner       = "DevOps"
}

# /*--------------------- Variable values for Subnet ----------------------------------------*/

subnet_name              = ["sub-pub-himanshuPoC-1"]
subnet_address_prefixes  = ["10.0.0.0/24"]
subnet_service_endpoints = ["Microsoft.AzureActiveDirectory"]

/*-------------------------------- Variable values for Virtual Machine -----------------*/

vm_name                          = ["himanshuPoC-linux-vm"]
vm_size                          = "Standard_DS3_v2"
vm_location                      = "Australia East"
delete_os_disk_on_termination    = true
delete_data_disks_on_termination = true
availability_zones               = [["1"]]

storage_image_reference = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
}

os_profile = {
  computer_name  = "hostname"
  admin_username = "ubuntu"
  admin_password = "Himanshu@123"
}



