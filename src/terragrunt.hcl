locals {
  storage_account_name = get_env("ARM_STORAGE_ACCOUNT_NAME")
  container_name       = get_env("ARM_STORAGE_ACCOUNT_CONTAINER")
}

remote_state {
  backend = "azurerm"
  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    storage_account_name = local.storage_account_name
    container_name       = local.container_name
  }
}

# Generate remote backend
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
# https://www.terraform.io/docs/backends/types/azurerm.html
terraform {
  backend "azurerm" {
    # ARM_ACCESS_KEY
  }
}
EOF
}
