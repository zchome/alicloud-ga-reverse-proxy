# Key Pair
resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = var.key_name

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
}

# Security Group
resource "alicloud_security_group" "default_group" {
  name        = "sg-${var.name}"
  description = "${var.name} Security Group"
  vpc_id      = var.vpc_id

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
}

# Security Group Rule
resource "alicloud_security_group_rule" "allow_https_tcp" {
  security_group_id = alicloud_security_group.default_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "443/443"
  ip_protocol       = "tcp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

# ECS Instances
resource "alicloud_instance" "instance" {

  availability_zone          = var.availability_zone
  security_groups            = alicloud_security_group.default_group.*.id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_efficiency"
  image_id                   = var.image_id
  instance_name              = "ecs-${var.name}"
  vswitch_id                 = var.vswitch_id
  internet_max_bandwidth_out = 5
  key_name                   = var.key_name

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }

  user_data = <<-EOF
#!/bin/sh
yum install nginx -y
  EOF
}