variable "test_vm_name" {
  default = "test_vm"
}

variable "location" {
  type        = string
  default     = "Australia East"
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable "test_vm_size" {
  default = "Standard_E2s_v3"
}

variable "test_vm_storage_image_reference" {
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "test_vm_storage_os_disk" {
  default = {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}

variable "test_vm_os_profile" {
  default = {
    computer_name  = "hostname"
    admin_username = "himanshu"
    admin_password = "Password1234!"
  }
}

variable "test_vm_os_profile_linux_config" {
  default = {
    disable_password_authentication = false
  }
}
