locals {
  shared_vars = read_terragrunt_config(find_in_parent_folders("shared.hcl"))

  resource_group = local.shared_vars.locals.resource_group
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/custom-domain"
}

inputs = {
  resource_group         = local.resource_group
  domain                 = "linuxcave.io"
  azure_txt_record       = "MS=ms24589658"
  office365_txt_record   = "v=spf1 include:spf.protection.outlook.com -all"
  office365_mx_record    = "linuxcave-io.mail.eo.outlook.com"
  office365_cname        = "autodiscover"
  office365_cname_record = "autodiscover.outlook.com"
}
