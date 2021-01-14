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
  resource_group         = var.resource_group
  domain                 = var.domain
  ttl                    = var.ttl
  azure_txt_record       = var.azure_txt_record
  office365_txt_record   = var.office365_txt_record
  office365_mx_record    = var.office365_mx_record
  office365_cname        = var.office365_cname
  office365_cname_record = var.office365_cname_record
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone
resource "azurerm_dns_zone" "domain" {
  name                = local.domain
  resource_group_name = local.resource_group
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record
resource "azurerm_dns_mx_record" "root" {
  name                = "@"
  zone_name           = azurerm_dns_zone.domain.name
  resource_group_name = local.resource_group
  ttl                 = local.ttl

  # Office 365
  record {
    preference = 10
    exchange   = local.office365_mx_record
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record
resource "azurerm_dns_txt_record" "root" {
  name                = "@"
  zone_name           = azurerm_dns_zone.domain.name
  resource_group_name = local.resource_group
  ttl                 = local.ttl

  # Azure
  record {
    value = local.azure_txt_record
  }

  # Office 365
  record {
    value = local.office365_txt_record
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record
resource "azurerm_dns_cname_record" "office365" {
  name                = local.office365_cname
  zone_name           = azurerm_dns_zone.domain.name
  resource_group_name = local.resource_group
  ttl                 = local.ttl
  record              = local.office365_cname_record
}
