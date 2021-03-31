locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name   = local.env_vars.locals.name
  region = local.env_vars.locals.region
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/kubernetes/upstream"
}

inputs = {
  name   = local.name
  region = local.region
}
