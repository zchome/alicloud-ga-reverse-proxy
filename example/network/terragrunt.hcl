terraform {
    source = "git::https://github.com/zchome/alicloud-ga-reverse-proxy.git//modules/network"
}

include {
    path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependencies {
    paths = ["../alicloud-data", "../resource-group"]
}

dependency "alicloud-data" {
    config_path = "../alicloud-data"
}

dependency "resource-group" {
    config_path = "../resource-group"
}

inputs = {
    name                    = local.common_vars.name
    availability_zone       = dependency.alicloud-data.outputs.alicloud_avalable_zone_id
    availability_zone_2     = dependency.alicloud-data.outputs.alicloud_avalable_zone_2_id
    resource_group_id       = dependency.resource-group.outputs.rg_id
    vpc_cidr                = local.common_vars.vpc_cidr
    vswitch_server_cidr     = local.common_vars.vswitch_server_cidr
    vswitch_server_2_cidr   = local.common_vars.vswitch_server_2_cidr
}