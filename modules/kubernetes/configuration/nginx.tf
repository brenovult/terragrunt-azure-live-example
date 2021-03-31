# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "nginx" {
  namespace = kubernetes_namespace.system.id

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  name       = "nginx"

  values = [templatefile("${path.module}/nginx.yaml", {
    loadBalancerIP            = var.aks_public_ip_address
    loadBalancerResourceGroup = var.aks_public_ip_resource_group
  })]
}
