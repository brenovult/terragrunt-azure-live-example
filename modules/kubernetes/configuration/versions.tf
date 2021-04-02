terraform {
  # https://releases.hashicorp.com/terraform/
  required_version = ">= 0.14"
  required_providers {
    kubernetes = {
      # https://github.com/hashicorp/terraform-provider-kubernetes/releases
      source  = "hashicorp/kubernetes"
      version = ">= 1.13, < 2.0.0"
    }
  }
}
