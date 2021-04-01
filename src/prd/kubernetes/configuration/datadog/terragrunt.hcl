# Workaround - Start
# RFC - https://terragrunt.gruntwork.io/docs/rfc/imports/
# Copy/Pasta - https://github.com/LinuxCave/terragrunt-azure-live-example/blob/main/src/terragrunt.hcl 
# Change remote_state_config_key
locals {
  storage_account_name = get_env("ARM_STORAGE_ACCOUNT_NAME")
  container_name       = get_env("ARM_STORAGE_ACCOUNT_CONTAINER")
}

remote_state {
  # https://www.terraform.io/docs/backends/types/azurerm.html
  backend = "azurerm"
  config = {
    key                  = "prd/kubernetes/configuration/datadog/terraform.tfstate"
    storage_account_name = local.storage_account_name
    container_name       = local.container_name
  }
}

# Generate remote backend
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    # ARM_ACCESS_KEY
  }
}
EOF
}
# Workaround - End

terraform {
  source = "../../../../../modules/kubernetes/datadog"

  extra_arguments "datadog" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var", "datadog_api_key=${get_env("DATADOG_API_KEY", "")}",
    ]
  }
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
  name                       = dependency.upstream.outputs.terraform_name
  aks_host                   = dependency.resources.outputs.aks_host
  aks_client_certificate     = dependency.resources.outputs.aks_client_certificate
  aks_client_key             = dependency.resources.outputs.aks_client_key
  aks_cluster_ca_certificate = dependency.resources.outputs.aks_cluster_ca_certificate
  namespace                  = dependency.configuration.outputs.system_namespace
}
