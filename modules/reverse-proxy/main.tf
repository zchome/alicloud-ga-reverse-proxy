# Key Pair
resource "alicloud_ecs_key_pair" "default" {
  count             = "${var.key_exist ? 0 : 1}"
  key_pair_name     = var.key_name

  resource_group_id = var.resource_group_id
  tags              = {
    poc = var.name
  }
}

# Security Group
resource "alicloud_security_group" "default_group" {
  name              = "sg-${var.name}"
  description       = "${var.name} Security Group"
  vpc_id            = var.vpc_id

  resource_group_id = var.resource_group_id
  tags              = {
    poc = var.name
  }
}

# Security Group Rules
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

resource "alicloud_security_group_rule" "allow_ssh" {
  security_group_id = alicloud_security_group.default_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "22/22"
  ip_protocol       = "tcp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

# ECS Instances
resource "alicloud_instance" "instance" {
  availability_zone           = var.availability_zone
  security_groups             = alicloud_security_group.default_group.*.id
  instance_type               = var.instance_type
  system_disk_category        = "cloud_efficiency"
  image_id                    = var.image_id
  instance_name               = "ecs-${var.name}"
  vswitch_id                  = var.vswitch_id
  internet_max_bandwidth_out  = "${var.enable_slb ? 0 : var.bandwidth}"
  key_name                    = var.key_name

  resource_group_id           = var.resource_group_id
  tags                        = {
    poc = var.name
  }

  user_data                   = <<-EOF
#!/bin/sh
yum install nginx nginx-mod-stream -y
systemctl restart nginx
  EOF
}

resource "alicloud_instance" "instance_2" {
  count                       = "${var.enable_slb ? 1 : 0}"
  availability_zone           = var.availability_zone_2
  security_groups             = alicloud_security_group.default_group.*.id
  instance_type               = var.instance_type
  system_disk_category        = "cloud_efficiency"
  image_id                    = var.image_id
  instance_name               = "ecs-${var.name}"
  vswitch_id                  = var.vswitch_id_2
  internet_max_bandwidth_out  = "${var.enable_slb ? 0 : var.bandwidth}"
  key_name                    = var.key_name

  resource_group_id           = var.resource_group_id
  tags                        = {
    poc = var.name
  }

  user_data                   = <<-EOF
#!/bin/sh
yum install nginx nginx-mod-stream -y
systemctl restart nginx
  EOF
}

# SLB
resource "alicloud_slb_load_balancer" "default" {
  count                   = "${var.enable_slb ? 1 : 0}"
  load_balancer_name      = "slb-${var.name}"
  load_balancer_spec      = "slb.s2.small"          # "slb.s1.small", "slb.s2.small", "slb.s2.medium", "slb.s3.small", "slb.s3.medium", "slb.s3.large" and "slb.s4.large"
  vswitch_id              = var.vswitch_id
  address_type            = "intranet"              # "intranet" "internet"
  # bandwidth               = "${var.bandwidth}"      # required with "PayByBandwidth"
  internet_charge_type    = "PayByTraffic"          # "PayByBandwidth" "PayByTraffic"
  master_zone_id          = var.availability_zone
  slave_zone_id           = var.availability_zone_2

  resource_group_id       = var.resource_group_id
  tags                    = {
    poc = var.name
  }
}

# SLB backend server
resource "alicloud_slb_backend_server" "default" {
  count                   = "${var.enable_slb ? 1 : 0}"
  load_balancer_id        = alicloud_slb_load_balancer.default.id
  backend_servers {
    server_id             = alicloud_instance.instance.id
    weight                = 100
  }
  backend_servers {
    server_id             = alicloud_instance.instance_2.id
    weight                = 100
  }
}

# SLB listener
resource "alicloud_slb_listener" "http" {
  count                   = "${var.enable_slb ? 1 : 0}"
  load_balancer_id        = alicloud_slb_load_balancer.default.id
  frontend_port           = 80
  backend_port            = 80
  protocol                = "http"
  bandwidth               = "${var.bandwidth}"
  sticky_session          = "on"
  sticky_session_type     = "insert"
}

resource "alicloud_slb_listener" "https" {
  count                   = "${var.enable_slb ? 1 : 0}"
  load_balancer_id        = alicloud_slb_load_balancer.default.id
  frontend_port           = 443
  backend_port            = 443
  protocol                = "tcp"
  bandwidth               = "${var.bandwidth}"
  sticky_session          = "on"
  sticky_session_type     = "insert"
}