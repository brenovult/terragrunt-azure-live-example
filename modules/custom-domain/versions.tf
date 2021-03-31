terraform {
  # https://releases.hashicorp.com/terraform/
  required_version = ">= 0.14"
  required_providers {
    azurerm = {
      # https://github.com/terraform-providers/terraform-provider-azurerm/releases
      source  = "hashicorp/azurerm"
      version = "=2.53.0"
    }
  }
}
