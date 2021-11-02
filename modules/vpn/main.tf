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
resource "alicloud_security_group_rule" "allow_vpn_udp_1" {
  security_group_id = alicloud_security_group.default_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "500/500"
  ip_protocol       = "udp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_vpn_udp_2" {
  security_group_id = alicloud_security_group.default_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "4500/4500"
  ip_protocol       = "udp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_http_tcp" {
  security_group_id = alicloud_security_group.default_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "80/80"
  ip_protocol       = "tcp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

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

resource "alicloud_security_group_rule" "allow_ssh_tcp" {
  security_group_id = alicloud_security_group.default_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "22/22"
  ip_protocol       = "tcp"
  priority          = "100"
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
yum install -y podman podman-compose
  EOF
}