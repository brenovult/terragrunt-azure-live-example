provider "helm" {
  kubernetes {
    host                   = var.aks_host
    client_certificate     = base64decode(var.aks_client_certificate)
    client_key             = base64decode(var.aks_client_key)
    cluster_ca_certificate = base64decode(var.aks_cluster_ca_certificate)
  }
}

resource "helm_release" "cert_manager" {
  namespace = var.namespace

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  name       = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }
}
