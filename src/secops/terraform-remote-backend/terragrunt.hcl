locals {
  name           = "linuxcave"
  region         = "westus2"
  resource_group = "secops"
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
