provider "helm" {
  kubernetes {
    host                   = var.aks_host
    client_certificate     = base64decode(var.aks_client_certificate)
    client_key             = base64decode(var.aks_client_key)
    cluster_ca_certificate = base64decode(var.aks_cluster_ca_certificate)
  }
}

resource "helm_release" "flux" {
  namespace = var.namespace

  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  name       = "flux"

  values = [templatefile("${path.module}/flux.yaml", {
    branch = "main"
  })]

  set_sensitive {
    name  = "git.url"
    value = "https://${var.git_user}:${var.git_password}@github.com/LinuxCave/terragrunt-azure-live-example.git"
  }
}
