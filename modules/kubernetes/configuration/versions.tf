terraform {
  # https://releases.hashicorp.com/terraform/
  required_version = ">= 0.14"
  required_providers {
    helm = {
      # https://github.com/hashicorp/terraform-provider-helm/releases
      source  = "hashicorp/helm"
      version = "=2.0.3"
    }
    kubernetes = {
      # https://github.com/hashicorp/terraform-provider-kubernetes/releases
      source  = "hashicorp/kubernetes"
      version = ">= 1.13, < 2.0.0"
    }
  }
}
