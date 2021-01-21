locals {
  shared_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name   = local.shared_vars.locals.name
  region = local.shared_vars.locals.region
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
