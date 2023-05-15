variable "nic_ip_configuration_subnet_id" {}

variable "nic_ip_configuration_private_ip_address_allocation" {
  default = "Dynamic"
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable "vm_size" {
  type        = string
  description = "(Required) Specifies the size of the Virtual Machine"
}
variable "availability_set_id" {
  type        = string
  description = "(Optional) The ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  default     = null
}
variable "delete_os_disk_on_termination" {
  type        = bool
  description = "(Optional) Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? Defaults to false."
  default     = false
}
variable "delete_data_disks_on_termination" {
  type        = bool
  description = "(Optional) Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? Defaults to false."
  default     = true
}
variable "primary_network_interface_id" {
  type        = string
  description = "(Optional) The ID of the Network Interface (which must be attached to the Virtual Machine) which should be the Primary Network Interface for this Virtual Machine."
  default     = null
}
variable "proximity_placement_group_id" {
  type        = string
  description = "(Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created"
  default     = null
}
variable "license_type" {
  type        = string
  description = "(Optional) Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows_Client and Windows_Server"
  default     = null
}
variable "tagMap" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the Virtual Machine."
  default = {

  }
}
variable "zones" {
  type        = list(string)
  description = "(Optional) A list of a single item of the Availability Zone which the Virtual Machine should be allocated in."
  default = [

  ]
}
variable "os_profile_linux_config" {
  type        = any
  description = "(Required, when a Linux machine) A os_profile_linux_config block."
  default = {

  }
}
variable "os_profile_windows_config" {
  type        = any
  description = "(Required, when a Windows machine) A os_profile_windows_config block."
  default = {

  }
}
variable "boot_diagnostics" {
  type        = list(any)
  description = "(Optional) A boot_diagnostics block"
  default = [

  ]
}
variable "additional_capabilities" {
  type        = list(any)
  description = "(Optional) A additional_capabilities block"
  default = [

  ]
}
variable "identity" {
  type        = list(any)
  description = "(Optional) A identity block"
  default = [

  ]
}
variable "os_profile" {
  type        = any
  description = "(Optional) An os_profile block. Required when create_option in the storage_os_disk block is set to FromImage"
  default = {

  }
}
variable "storage_os_disk" {
  type        = any
  description = "(Required) A storage_os_disk block."
  default = {

  }
}
variable "os_profile_secrets" {
  type        = list(any)
  description = "(Optional) One or more os_profile_secrets blocks"
  default = [

  ]
}

variable "plan" {
  type        = list(any)
  description = "(Optional) A plan block"
  default = [

  ]
}
variable "storage_data_disk" {
  type        = list(any)
  description = "(Optional) One or more storage_data_disk blocks"
  default = [

  ]
}
variable "storage_image_reference" {
  type        = any
  description = "(Optional) A storage_image_reference block"
  default = {

  }
}
