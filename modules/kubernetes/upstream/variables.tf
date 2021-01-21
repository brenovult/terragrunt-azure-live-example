# Terraform
variable "name" {
  description = "Unique name for Terraform resources"
  type        = string
}

# Azure
variable "region" {
  description = "The Azure region for resources"
  type        = string
}
