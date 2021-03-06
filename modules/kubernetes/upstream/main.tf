# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs
provider "azuread" {
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs
provider "random" {
}

# Configurations
locals {
  name     = var.name
  location = var.region
}

# Azure Active Directory

## AKS

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application
resource "azuread_application" "aks" {
  display_name = "${local.name}-aks"

  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.application_id
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "aks" {
  length           = 32
  special          = true
  override_special = "+*=?_.:@[]"
  min_special      = 4
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password
resource "azuread_application_password" "aks" {
  application_object_id = azuread_application.aks.id
  value                 = random_password.aks.result
  end_date_relative     = "8760h"
}

## Terraform

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application
resource "azuread_application" "terraform" {
  display_name = "${local.name}-terraform"

  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "terraform" {
  application_id = azuread_application.terraform.application_id
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "terraform" {
  length           = 32
  special          = true
  override_special = "+*=?_.:@[]"
  min_special      = 4
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password
resource "azuread_application_password" "terraform" {
  application_object_id = azuread_application.terraform.id
  value                 = random_password.terraform.result
  end_date_relative     = "8760h"
}

# Azure

## Resources

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "resources" {
  name     = local.name
  location = local.location
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "aks" {
  scope                = azurerm_resource_group.resources.id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.aks.object_id
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "resources_terraform" {
  scope                = azurerm_resource_group.resources.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.terraform.object_id
}

## Security
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "security" {
  name                = "${local.name}security"
  resource_group_name = azurerm_resource_group.resources.name
  location            = local.location

  account_tier              = "Premium"
  account_kind              = "BlockBlobStorage"
  account_replication_type  = "LRS"
  allow_blob_public_access  = "true"
  enable_https_traffic_only = "true"
  min_tls_version           = "TLS1_2"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "security_terraform" {
  scope                = azurerm_resource_group.resources.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.terraform.object_id
}
