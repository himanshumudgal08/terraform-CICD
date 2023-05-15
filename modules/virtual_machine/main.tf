resource "azurerm_virtual_machine" "vm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  availability_set_id = var.availability_set_id

  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  delete_data_disks_on_termination = var.delete_data_disks_on_termination # default is true


  primary_network_interface_id = var.primary_network_interface_id
  proximity_placement_group_id = var.proximity_placement_group_id

  license_type = var.license_type # only for windows

  zones = var.zones

  dynamic "os_profile_linux_config" {
    for_each = length(var.os_profile_linux_config) == 0 ? [] : [var.os_profile_linux_config]

    content {
      disable_password_authentication = lookup(os_profile_linux_config.value, "disable_password_authentication")
      dynamic "ssh_keys" {
        for_each = length(keys(lookup(os_profile_linux_config.value, "ssh_keys", {}))) == 0 ? [] : [lookup(os_profile_linux_config.value, "ssh_keys", {})]
        content {
          key_data = lookup(ssh_keys.value, "key_data")
          path     = lookup(ssh_keys.value, "path")
        }
      }

    }
  }

  dynamic "os_profile_windows_config" {
    for_each = length(var.os_profile_windows_config) == 0 ? [] : [var.os_profile_windows_config]
    content {
      provision_vm_agent        = lookup(os_profile_windows_config.value, "provision_vm_agent", true)
      enable_automatic_upgrades = lookup(os_profile_windows_config.value, "enable_automatic_upgrades", true)
      timezone                  = lookup(os_profile_windows_config.value, "timezone", "Singapore Standard Time")
      dynamic "winrm" {
        for_each = length(keys(lookup(os_profile_windows_config.value, "winrm", {}))) == 0 ? [] : [lookup(os_profile_windows_config.value, "winrm", {})]
        content {
          protocol        = lookup(winrm.value, "protocol")
          certificate_url = lookup(winrm.value, "certificate_url", null)
        }
      }
      dynamic "additional_unattend_config" {
        for_each = length(keys(lookup(os_profile_windows_config.value, "additional_unattend_config", {}))) == 0 ? [] : [lookup(os_profile_windows_config.value, "additional_unattend_config", {})]
        content {
          pass         = lookup(additional_unattend_config.value, "pass")
          component    = lookup(additional_unattend_config.value, "component", "Microsoft-Windows-Shell-Setup")
          setting_name = lookup(additional_unattend_config.value, "setting_name")
          content      = lookup(additional_unattend_config.value, "content", null)
        }
      }
    }
  }

  dynamic "boot_diagnostics" {
    for_each = length(var.boot_diagnostics) == 0 ? [] : [var.boot_diagnostics]
    content {
      enabled     = lookup(boot_diagnostics.value, "enabled")
      storage_uri = lookup(boot_diagnostics.value, "storage_uri")

    }
  }

  dynamic "additional_capabilities" {
    for_each = length(var.additional_capabilities) == 0 ? [] : [var.additional_capabilities]
    content {
      ultra_ssd_enabled = lookup(additional_capabilities.value, "ultra_ssd_enabled")
    }
  }

  dynamic "identity" {
    for_each = length(var.identity) == 0 ? [] : [var.identity]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "os_profile" {
    for_each = length(var.os_profile) == 0 ? [] : [var.os_profile]
    content {
      computer_name  = lookup(os_profile.value, "computer_name")
      admin_username = lookup(os_profile.value, "admin_username")
      admin_password = lookup(os_profile.value, "admin_password", null)
      custom_data    = lookup(os_profile.value, "custom_data", null)
    }
  }

  dynamic "os_profile_secrets" {
    for_each = length(var.os_profile_secrets) == 0 ? [] : [var.os_profile_secrets]
    content {
      source_vault_id = lookup(os_profile_secrets.value, "source_vault_id")
      dynamic "vault_certificates" {
        for_each = length(keys(lookup(os_profile_secrets.value, "vault_certificates", {}))) == 0 ? [] : [lookup(os_profile_secrets.value, "vault_certificates", {})]
        content {
          certificate_url   = lookup(vault_certificates.value, "certificate_url")
          certificate_store = lookup(vault_certificates.value, "certificate_store")
        }
      }
    }
  }

  dynamic "plan" {
    for_each = length(var.plan) == 0 ? [] : [var.plan]
    content {
      name      = lookup(plan.value, "name")
      publisher = lookup(plan.value, "publisher")
      product   = lookup(plan.value, "product")
    }
  }

  dynamic "storage_data_disk" {
    for_each = length(var.storage_data_disk) == 0 ? [] : [var.storage_data_disk]
    content {
      name                      = lookup(storage_data_disk.value, "name")
      caching                   = lookup(storage_data_disk.value, "caching", "None")
      create_option             = lookup(storage_data_disk.value, "create_option")
      disk_size_gb              = lookup(storage_data_disk.value, "disk_size_gb", null)
      lun                       = lookup(storage_data_disk.value, "lun")
      write_accelerator_enabled = lookup(storage_data_disk.value, "write_accelerator_enabled", false)
      managed_disk_type         = lookup(storage_data_disk.value, "managed_disk_type", null)
      managed_disk_id           = lookup(storage_data_disk.value, "managed_disk_id", null)
      vhd_uri                   = lookup(storage_data_disk.value, "vhd_uri", null)
    }
  }
  dynamic "storage_image_reference" {
    for_each = length(var.storage_image_reference) == 0 ? [] : [var.storage_image_reference]
    content {
      publisher = lookup(storage_image_reference.value, "publisher", null)
      offer     = lookup(storage_image_reference.value, "offer", null)
      sku       = lookup(storage_image_reference.value, "sku", null)
      version   = lookup(storage_image_reference.value, "version", null)
      id        = lookup(storage_image_reference.value, "id", null)
    }
  }

  dynamic "storage_os_disk" {
    for_each = length(var.storage_os_disk) == 0 ? [] : [var.storage_os_disk]
    content {
      name                      = lookup(storage_os_disk.value, "name")
      create_option             = lookup(storage_os_disk.value, "create_option")
      caching                   = lookup(storage_os_disk.value, "caching", "None")
      disk_size_gb              = lookup(storage_os_disk.value, "disk_size_gb", null)
      image_uri                 = lookup(storage_os_disk.value, "image_uri", null)
      os_type                   = lookup(storage_os_disk.value, "os_type", null)
      write_accelerator_enabled = lookup(storage_os_disk.value, "write_accelerator_enabled", null)
      managed_disk_id           = lookup(storage_os_disk.value, "managed_disk_id", null)
      managed_disk_type         = lookup(storage_os_disk.value, "managed_disk_type", null)
      vhd_uri                   = lookup(storage_os_disk.value, "vhd_uri", null)
    }
  }


  tags = var.tagMap
}
