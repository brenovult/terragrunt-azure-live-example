locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name           = local.env_vars.locals.name
  region         = local.env_vars.locals.region
  resource_group = "terraform-remote-backend"
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/terraform-remote-backend"
}

inputs = {
  name           = local.name
  region         = local.region
  resource_group = local.resource_group
}
