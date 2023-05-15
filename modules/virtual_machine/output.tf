output "id" {
  value = azurerm_virtual_machine.vm.*.id
}

output "nic_id" {
  value       = azurerm_network_interface.nic.*.id
}
