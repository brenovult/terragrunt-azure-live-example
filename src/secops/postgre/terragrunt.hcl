include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/LinuxCave/scratch.git//retool/terraform?ref=retool-wip"
}

inputs = {
  name           = "linuxcaveretool"
  region         = "westus2"
  resource_group = "retool"
}
