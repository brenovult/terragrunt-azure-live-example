include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/kubernetes/resources"
}

dependency "upstream" {
  config_path = "../upstream"
}

inputs = {
  name                       = dependency.upstream.outputs.terraform_name
  region                     = dependency.upstream.outputs.azure_region
  resource_group             = dependency.upstream.outputs.azure_resource_group
  log_analytics_workspace_id = dependency.upstream.outputs.security_log_analytics_workspace_id
  aks_client_id              = dependency.upstream.outputs.aks_client_id
  aks_client_secret          = dependency.upstream.outputs.aks_client_secret
}
