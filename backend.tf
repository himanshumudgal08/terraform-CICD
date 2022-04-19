terraform {
  backend "azurerm" {
    resource_group_name  = "terraformInfo"
    storage_account_name = "terraformrfvars98"
    container_name       = "blob3"
    key                  = "terraform.tfstate"
  }
}
