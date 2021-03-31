# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "datadog_agent" {
  namespace = var.namespace

  repository = "https://helm.datadoghq.com"
  name       = "datadog-agent"
  chart      = "datadog"

  values = compact([
    templatefile("${path.module}/datadog.yaml", {
      clusterName = var.namespace
    })
  ])

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }
}
