output "subnet_id" {
  value       = var.create_delegation == true ? azurerm_subnet.module_subnet_with_delegation.*.id : azurerm_subnet.module_subnet_without_delegation.*.id
  description = "ID of the subnet"
}

output "subnet_name" {
  value       = var.create_delegation == true ? azurerm_subnet.module_subnet_with_delegation.*.name : azurerm_subnet.module_subnet_without_delegation.*.name
  description = "Name of the subnet"
}

output "subnet_address_prefixes" {
  value       = var.create_delegation == true ? azurerm_subnet.module_subnet_with_delegation.*.address_prefixes : azurerm_subnet.module_subnet_without_delegation.*.address_prefixes
  description = "Address prefixed of the subnet"
}
