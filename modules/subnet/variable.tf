variable "resource_group_name" {
  description = "The variable for resource group name"
  type        = string
}

variable "subnet_name" {
  description = "The variable for subnet name"
  type        = list(string)
}


variable "vnet_name" {
  description = "The CIDR block for the vnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The CIDR block for the vnet"
  type        = list(string)
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet"
  type        = list(string)
}

variable "create_delegation" { 
  description = "Creating delegation parameter or not"
  type        = bool
  default     = true
}
variable "delegation_name" {
  description = "Delegation configuration for subnet"
  type        = map(list(any))
  default     = {}
}
