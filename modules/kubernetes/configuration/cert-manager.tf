resource "helm_release" "cert_manager" {
  namespace = kubernetes_namespace.system.id

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  name       = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }
}
