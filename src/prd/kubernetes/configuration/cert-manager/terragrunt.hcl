terraform {
  source = "../../../../../modules/kubernetes/cert-manager"
}

dependency "upstream" {
  config_path = "../../upstream"
}

dependency "resources" {
  config_path = "../../resources"
}

dependency "configuration" {
  config_path = "../"
}

inputs = {
  name                         = dependency.upstream.outputs.terraform_name
  aks_host                     = dependency.resources.outputs.aks_host
  aks_client_certificate       = dependency.resources.outputs.aks_client_certificate
  aks_client_key               = dependency.resources.outputs.aks_client_key
  aks_cluster_ca_certificate   = dependency.resources.outputs.aks_cluster_ca_certificate
  aks_public_ip_address        = dependency.resources.outputs.aks_public_ip_address
  aks_public_ip_resource_group = dependency.resources.outputs.aks_public_ip_resource_group
  namespace                    = dependency.configuration.outputs.system_namespace
}
