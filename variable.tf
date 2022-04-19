/*---------------------- Variable for Resource Group --------------------------*/

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of Resource Group"
}

variable "resource_group_location" {
  type        = string
  description = "(Required) Location where we want to implement code"
}

variable "rg_tags" {
  type        = map(string)
  description = "(Optional) Tags for Resource Group"
}

variable "lock_level_value" {
  type        = string
  default     = ""
  description = "Specifies the Level to be used for this Lock. Possible values are `Empty (no lock)`, `CanNotDelete` and `ReadOnly`"
}

/*---------------------- Variable for Vnet ---------------------------------------*/

variable "vnet_name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
}

variable "address_space" {
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
  type        = list(any)
}

variable "create_ddos_protection_plan" {
  description = "(Required) Create an ddos plan - Default is false"
  type        = bool
}

variable "dns_servers" {
  description = "(Optional) List of IP addresses of DNS servers"
  type        = list(string)
}

variable "vnet_tags" {
  type        = map(string)
  description = "(Optional) Tags for Resource Group"
}

# /*-------------------------- Variable for Subnet -------------------------------------------*/

variable "subnet_address_prefixes" {
  description = "The CIDR block for the vnet"
  type        = list(string)
}

variable "subnet_name" {
  description = "The variable for subnet name"
  type        = list(string)
}

variable "subnet_service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet"
  type        = list(string)
}

# /*---------------------------- Variables for Virtual Machine ----------------------------*/

variable "vm_name" {
  type        = list(string)
  description = "(Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created."
}

variable "vm_size" {
  type        = string
  description = "(Required) Specifies the size of the Virtual Machine"
}

variable "storage_image_reference" {
  type        = any
  description = "(Optional) A storage_image_reference block"
}

variable "os_profile" {
  type        = any
  description = "(Optional) An os_profile block. Required when create_option in the storage_os_disk block is set to FromImage"
}

variable "vm_location" {
  type        = string
  description = "VM location"
}

variable "delete_os_disk_on_termination" {
  type = bool
}

variable "delete_data_disks_on_termination" {
  type = bool
}

variable "availability_zones" {
  type        = any
  description = "(Optional) A list of a single item of the Availability Zone which the Virtual Machine should be allocated in."
}
