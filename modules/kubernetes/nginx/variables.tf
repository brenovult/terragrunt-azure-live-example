# Terraform
variable "name" {
  description = "Unique name for Terraform resources"
  type        = string
}

# Kubernetes
variable "aks_host" {
  description = "The Kubernetes cluster server host."
  type        = string
}

variable "aks_client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  type        = string
}

variable "aks_client_key" {
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  type        = string
}

variable "aks_cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace"
  type        = string
}

# NGINX
variable "aks_public_ip_address" {
  description = "The public IP address for Kubernetes ingress."
  type        = string
}

variable "aks_public_ip_resource_group" {
  description = "The resource group for the public ip address."
  type        = string
}
