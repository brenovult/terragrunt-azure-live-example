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

# Flux
variable "git_user" {
  description = "Username to use for Git"
  type        = string
}

variable "git_password" {
  description = "Password to use for Git"
  type        = string
}
