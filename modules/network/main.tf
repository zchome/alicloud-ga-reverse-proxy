# VPC
resource "alicloud_vpc" "vpc" {
  vpc_name          = "vpc-${var.name}"
  cidr_block        = var.vpc_cidr
  resource_group_id = var.resource_group_id

  tags              = {
    poc = var.name
  }
}

# vSwitch
resource "alicloud_vswitch" "vswitch_server" {
  vswitch_name  = "vswitch-server-${var.name}"
  vpc_id        = alicloud_vpc.vpc.id
  cidr_block    = var.vswitch_server_cidr
  zone_id       = var.availability_zone

  tags          = {
    poc = var.name
  }
}

resource "alicloud_vswitch" "vswitch_server_2" {
  vswitch_name  = "vswitch-server-${var.name}"
  vpc_id        = alicloud_vpc.vpc.id
  cidr_block    = var.vswitch_server_2_cidr
  zone_id       = var.availability_zone_2

  tags          = {
    poc = var.name
  }
}

# resource "alicloud_vswitch" "vswitch_db" {
#   vswitch_name = "vswitch-db-${var.name}"
#   vpc_id       = alicloud_vpc.vpc.id
#   cidr_block   = var.vswitch_db_cidr
#   zone_id      = var.availability_zone

#   tags = {
#     poc = var.name
#   }
# }