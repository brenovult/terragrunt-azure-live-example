# Kubernetes
output "system_namespace" {
  description = "The namespace for system resources"
  value       = kubernetes_namespace.system.id
}

output "scratch_namespace" {
  description = "The namespace for scratch resources"
  value       = kubernetes_namespace.scratch.id
}
