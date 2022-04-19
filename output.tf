output "vm_private_key" {
  value     = tls_private_key.vm_key.private_key_pem
  sensitive = true
}