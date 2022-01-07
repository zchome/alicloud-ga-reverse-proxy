terraform {
    source = "git::https://github.com/zchome/alicloud-ga-reverse-proxy.git//modules/resource-group"
}

include {
    path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
    name    = local.common_vars.name
}