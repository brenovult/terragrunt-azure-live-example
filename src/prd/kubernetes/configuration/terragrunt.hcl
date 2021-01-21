include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/kubernetes/configuration"

  extra_arguments "datadog" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var", "datadog_api_key=${get_env("DATADOG_API_KEY", "")}",
    ]
  }

  extra_arguments "flux" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var", "flux_git_user=${get_env("GIT_AUTHUSER", "")}",
      "-var", "flux_git_password=${get_env("GIT_AUTHKEY", "")}"
    ]
  }

  extra_arguments "ghcr" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var", "ghcr_user=${get_env("GHCR_USER", "")}",
      "-var", "ghcr_password=${get_env("GHCR_PASSWORD", "")}"
    ]
  }
}

dependency "upstream" {
  config_path = "../upstream"
}

dependency "resources" {
  config_path = "../resources"
}

inputs = {
  name                         = dependency.upstream.outputs.terraform_name
  aks_host                     = dependency.resources.outputs.aks_host
  aks_client_certificate       = dependency.resources.outputs.aks_client_certificate
  aks_client_key               = dependency.resources.outputs.aks_client_key
  aks_cluster_ca_certificate   = dependency.resources.outputs.aks_cluster_ca_certificate
  aks_public_ip_address        = dependency.resources.outputs.aks_public_ip_address
  aks_public_ip_resource_group = dependency.resources.outputs.aks_public_ip_resource_group
}
