resource "azurerm_subnet" "module_subnet_with_delegation" {
  count                = var.create_delegation == true ? length(var.subnet_address_prefixes) : 0
  name                 = element(var.subnet_name, count.index)
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
  service_endpoints    = var.service_endpoints

   dynamic "delegation" {
    for_each = var.delegation_name
    content {
        name = delegation.key

  dynamic "service_delegation" {
    for_each = toset(delegation.value)
     content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
       }  
     }
    }
  }
}


resource "azurerm_subnet" "module_subnet_without_delegation" {
  count                = var.create_delegation != true ? length(var.subnet_address_prefixes) : 0
  name                 = element(var.subnet_name, count.index)
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
  service_endpoints    = var.service_endpoints
}
