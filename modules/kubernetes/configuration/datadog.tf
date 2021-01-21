# https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file
data "template_file" "datadog_values" {
  template = file("${path.module}/datadog.yaml")

  vars = {
    clusterName = local.name
  }
}

# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "datadog_agent" {
  namespace = "${local.name}-system"

  repository = "https://helm.datadoghq.com"
  name       = "datadog-agent"
  chart      = "datadog"

  values = compact([
    data.template_file.datadog_values.rendered
  ])

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }
}
