provider "helm" {
  kubernetes {
    host                   = var.aks_host
    client_certificate     = base64decode(var.aks_client_certificate)
    client_key             = base64decode(var.aks_client_key)
    cluster_ca_certificate = base64decode(var.aks_cluster_ca_certificate)
  }
}

# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "nginx" {
  namespace = var.namespace

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  name       = "nginx"

  values = [templatefile("${path.module}/nginx.yaml", {
    loadBalancerIP            = var.aks_public_ip_address
    loadBalancerResourceGroup = var.aks_public_ip_resource_group
  })]
}
