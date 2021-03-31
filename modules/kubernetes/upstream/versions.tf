terraform {
  # https://releases.hashicorp.com/terraform/
  required_version = ">= 0.14"
  required_providers {
    azurerm = {
      # https://github.com/terraform-providers/terraform-provider-azurerm/releases
      source  = "hashicorp/azurerm"
      version = "=2.53.0"
    }
    azuread = {
      # https://github.com/hashicorp/terraform-provider-azuread/releases
      source  = "hashicorp/azuread"
      version = "=1.4.0"
    }
    random = {
      # https://github.com/hashicorp/terraform-provider-random/releases
      source  = "hashicorp/random"
      version = "=3.1.0"
    }
  }
}
