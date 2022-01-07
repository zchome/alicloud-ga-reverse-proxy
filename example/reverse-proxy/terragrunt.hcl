terraform {
    source = "git::https://github.com/zchome/alicloud-ga-reverse-proxy.git//modules/reverse-proxy"
}

include {
    path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependencies {
    paths = ["../alicloud-data", "../resource-group", "../network"]
}

dependency "alicloud-data" {
    config_path = "../alicloud-data"
}

dependency "resource-group" {
    config_path = "../resource-group"
}

dependency "network" {
    config_path = "../network"
}

inputs = {
    name                    = local.common_vars.name
    resource_group_id       = dependency.resource-group.outputs.rg_id
    vpc_id                  = dependency.network.outputs.vpc_id
    vswitch_id              = dependency.network.outputs.vswitch_server_id
    availability_zone       = dependency.alicloud-data.outputs.alicloud_avalable_zone_id
    availability_zone_2     = dependency.alicloud-data.outputs.alicloud_avalable_zone_2_id
    key_name                = local.common_vars.key_name
    enable_slb              = false
    key_exist               = true
}