# https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file
data "template_file" "regcred" {
  template = file("${path.module}/regcred.json")
  vars = {
    docker_username = var.ghcr_user
    docker_password = var.ghcr_password
    docker_server   = "ghcr.io"
    auth            = base64encode("${var.ghcr_user}:${var.ghcr_password}")
  }
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret
# https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
resource "kubernetes_secret" "scratch_docker_registry" {
  metadata {
    name      = "regcred"
    namespace = kubernetes_namespace.scratch.id
  }

  data = {
    ".dockerconfigjson" = data.template_file.regcred.rendered
  }

  type = "kubernetes.io/dockerconfigjson"
}
