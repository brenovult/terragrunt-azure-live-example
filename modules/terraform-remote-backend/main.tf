# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}
  # ARM_TENANT_ID
  # ARM_SUBSCRIPTION_ID
  # ARM_CLIENT_ID
  # ARM_CLIENT_SECRET
}

# Configurations
locals {
  name           = var.name
  location       = var.region
  resource_group = var.resource_group
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "azurerm" {
  name                = local.name
  resource_group_name = local.resource_group
  location            = local.location

  account_tier              = "Premium"
  account_kind              = "BlockBlobStorage"
  account_replication_type  = "LRS"
  allow_blob_public_access  = "true"
  enable_https_traffic_only = "true"
  min_tls_version           = "TLS1_2"
}
