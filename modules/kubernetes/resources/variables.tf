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

variable "resource_group" {
  description = "The Azure resource group for resources"
  type        = string
}

# Security
variable "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID for security"
  type        = string
}

# AKS
variable "aks_client_id" {
  description = "The Client ID for the AKS Service Principal."
  type        = string
}

variable "aks_client_secret" {
  description = "The Client Secret for the AKS Service Principal."
  type        = string
}

variable "aks_oms_agent_enabled" {
  description = "Enables Log Analytics agent on AKS nodes. This is a an Azure Security Center recommendation that costs ~$4.00 per node per day."
  type        = bool
  default     = false
}
