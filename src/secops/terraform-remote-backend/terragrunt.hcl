locals {
  shared_vars = read_terragrunt_config(find_in_parent_folders("shared.hcl"))

  name           = local.shared_vars.locals.name
  region         = local.shared_vars.locals.region
  resource_group = local.shared_vars.locals.resource_group
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
