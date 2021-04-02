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
  name                        = dependency.upstream.outputs.terraform_name
  region                      = dependency.upstream.outputs.azure_region
  resource_group              = dependency.upstream.outputs.azure_resource_group
  security_storage_account_id = dependency.upstream.outputs.security_storage_account_id
  aks_client_id               = dependency.upstream.outputs.aks_client_id
  aks_client_secret           = dependency.upstream.outputs.aks_client_secret
}
