# Providers
provider "template" {
}

provider "kubernetes" {
  load_config_file       = false
  host                   = var.aks_host
  client_certificate     = base64decode(var.aks_client_certificate)
  client_key             = base64decode(var.aks_client_key)
  cluster_ca_certificate = base64decode(var.aks_cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = var.aks_host
    client_certificate     = base64decode(var.aks_client_certificate)
    client_key             = base64decode(var.aks_client_key)
    cluster_ca_certificate = base64decode(var.aks_cluster_ca_certificate)
  }
}

# Configurations
locals {
  name = var.name
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "system" {
  metadata {
    name = "${local.name}-system"
  }
}

resource "kubernetes_namespace" "scratch" {
  metadata {
    name = "${local.name}-scratch"
  }
}
