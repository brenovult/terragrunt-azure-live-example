# AKS
output "aks_client_id" {
  description = "The Client ID for the AKS Service Principal."
  value       = azuread_service_principal.aks.application_id
}

output "aks_client_secret" {
  description = " The Client Secret for the AKS Service Principal."
  value       = random_password.aks.result
  sensitive   = true
}

# Terraform
output "terraform_name" {
  description = "Unique name for Terraform resources"
  value       = local.name
}

output "terraform_client_id" {
  description = "The Client ID for the Terraform Service Principal."
  value       = azuread_service_principal.aks.application_id
}

output "terraform_client_secret" {
  description = " The Client Secret for the Terraform Service Principal."
  value       = random_password.aks.result
  sensitive   = true
}

# Resources
output "azure_resource_group" {
  description = "The resource group for Azure resources"
  value       = azurerm_resource_group.resources.name
}

output "azure_region" {
  description = "The region for Azure resources"
  value       = azurerm_resource_group.resources.location
}

# Security
output "security_log_analytics_workspace_id" {
  description = "The id of the Log Analytics Workspace for security."
  value       = azurerm_log_analytics_workspace.security.id
}
