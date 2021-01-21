data "template_file" "flux_values" {
  template = file("${path.module}/flux.yaml")
}

resource "helm_release" "flux" {
  namespace = kubernetes_namespace.system.id

  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  name       = "flux"

  values = compact([
    data.template_file.flux_values.rendered
  ])

  set_sensitive {
    name  = "git.url"
    value = "https://${var.flux_git_user}:${var.flux_git_password}@github.com/LinuxCave/terragrunt-azure-live-example.git"
  }
}
