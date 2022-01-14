terraform {
    source = "git::https://github.com/zchome/alicloud-ga-reverse-proxy.git//modules/ga"
}

include {
    path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependencies {
    paths = ["../reverse-proxy"]
}

dependency "reverse-proxy" {
    config_path = "../reverse-proxy"
}

inputs = {
    name                    = local.common_vars.name
    endpoint_ip_address     = dependency.reverse-proxy.outputs.slb_public_ip
    accelerate_region_id    = local.common_vars.accelerate_region_id
    endpoint_group_region   = local.common_vars.endpoint_group_region
}