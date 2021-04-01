provider "helm" {
  kubernetes {
    host                   = var.aks_host
    client_certificate     = base64decode(var.aks_client_certificate)
    client_key             = base64decode(var.aks_client_key)
    cluster_ca_certificate = base64decode(var.aks_cluster_ca_certificate)
  }
}

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
