# Azure
variable "resource_group" {
  description = "The Azure resource group for resources"
  type        = string
}

# Domain
variable "domain" {
  description = "The domain to configure for Azure and Office 365"
  type        = string
}

variable ttl {
  description = "The time to live for all custom domain records"
  type        = number
  default     = 3600
}

# Azure
variable "azure_txt_record" {
  description = "Custom domain txt record for Azure"
  type        = string
}

# Office365
variable "office365_txt_record" {
  description = "The custom domain txt record for Office 365"
  type        = string
}

variable "office365_mx_record" {
  description = "The custom domain mx record for Office 365"
  type        = string
}

variable "office365_cname" {
  description = "The custom domain cname for Office 365"
  type        = string
}

variable "office365_cname_record" {
  description = "The custom domain cname record for Office 365"
  type        = string
}
