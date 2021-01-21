# Azure Resources

# AKS
output "aks_public_ip_address" {
  description = "The public IP address for Kubernetes ingress."
  value       = azurerm_public_ip.aks.ip_address
}

output "aks_public_ip_resource_group" {
  description = "The resource group for the public ip address."
  value       = local.resource_group
}

output "aks_cluster_name" {
  description = "The Kubernetes cluster name."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_host" {
  description = "The Kubernetes cluster server host."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "aks_client_key" {
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
}

output "aks_client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
}

output "aks_cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
}
