Terraform Module for deploying VM
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png



- This terraform module will create a Virtual Machine.
- This projecct is a part of opstree's ot-azure initiative for terraform modules.


Usage
------


```hcl

module "vm_module" {
  source = "../"
  nic_ip_configuration_subnet_id = module.subnet_module.subnet_id[0]
  name                    = var.test_vm_name
  resource_group_name     = var.rg_name
  location                = var.rg_location
  vm_size                 = var.test_vm_size
  storage_image_reference = var.test_vm_storage_image_reference
  storage_os_disk         = var.test_vm_storage_os_disk
  os_profile              = var.test_vm_os_profile
  os_profile_linux_config = var.test_vm_os_profile_linux_config

  
}


```

```sh

$   cat output.tf
/*-------------------------------------------------------*/

output "nic_id" {
  value       = azurerm_network_interface.nic.id
}


/*-------------------------------------------------------*/
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | (Required) A list of Network Interface ID's which should be associated with the Virtual Machine. | `list(string)` | n/a | yes |
| <a name="input_os_profile"></a> [os\_profile](#input\_os\_profile) | (Optional) An os\_profile block. Required when create\_option in the storage\_os\_disk block is set to FromImage | `any` | `{}` | no |
| <a name="input_os_profile_linux_config"></a> [os\_profile\_linux\_config](#input\_os\_profile\_linux\_config) | (Required, when a Linux machine) A os\_profile\_linux\_config block. | `any` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_storage_image_reference"></a> [storage\_image\_reference](#input\_storage\_image\_reference) | (Optional) A storage\_image\_reference block | `any` | `{}` | no |
| <a name="input_storage_os_disk"></a> [storage\_os\_disk](#input\_storage\_os\_disk) | (Required) A storage\_os\_disk block. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the Virtual Machine. | `map(string)` | `{}` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) Specifies the size of the Virtual Machine | `string` | n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| nic_id | Network Interface ID's which should be associated with the Virtual Machine |



### Contributors

### Contributors
|  [![Akanksha Srivastava][Akanksha_avatar]][akanksha.s_homepage]<br/>[Akanksha Sriastava][akanksha.s_homepage] |

 
  [akanksha.s_homepage]:https://gitlab.com/akanksha.s
  [Akanksha_avatar]: https://gitlab.com/uploads/-/system/user/avatar/8698995/avatar.png?width=400

