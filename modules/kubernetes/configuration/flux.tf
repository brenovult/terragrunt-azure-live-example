resource "helm_release" "flux" {
  namespace = kubernetes_namespace.system.id

  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  name       = "flux"

  values = [templatefile("${path.module}/flux.yaml", {
    branch = "main"
  })]

  set_sensitive {
    name  = "git.url"
    value = "https://${var.flux_git_user}:${var.flux_git_password}@github.com/LinuxCave/terragrunt-azure-live-example.git"
  }
}
