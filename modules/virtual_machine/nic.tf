resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = var.name
    subnet_id                     = var.nic_ip_configuration_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
