# Security Group
resource "alicloud_security_group" "server_group" {
  name        = "sg-server-${var.name}"
  description = "${var.name} server security group"
  vpc_id      = var.vpc_id

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
}

# Security Group Rule
resource "alicloud_security_group_rule" "allow_http_tcp" {
  security_group_id = alicloud_security_group.server_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "80/80"
  ip_protocol       = "tcp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_icmp_tcp" {
  security_group_id = alicloud_security_group.server_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "3389/3389"
  ip_protocol       = "tcp"
  priority          = "50"
  cidr_ip           = "0.0.0.0/0"
}

# ECS Instances
resource "alicloud_instance" "instance" {

  availability_zone          = var.availability_zone
  security_groups            = alicloud_security_group.server_group.*.id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_efficiency"
  image_id                   = var.image_id
  instance_name              = "ecs-${var.name}"
  count                      = 2
  vswitch_id                 = var.vswitch_server_id
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = "5"
  password                   = var.password

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
  user_data = <<-EOF
[powershell]
Install-WindowsFeature -name Web-Server -IncludeManagementTools
  EOF

}

# SLB Instance
resource "alicloud_slb_load_balancer" "default" {
  load_balancer_name   = "slb-${var.name}"
  address_type         = "internet"
  load_balancer_spec   = var.load_balancer_spec
  vswitch_id           = var.vswitch_server_id
  internet_charge_type = "PayByTraffic"
  bandwidth            = 10

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
}

# resource "alicloud_slb_server_group" "default" {
#     load_balancer_id = alicloud_slb_load_balancer.default.id
#     name             = var.name
#     servers {
#         server_ids = [alicloud_instance.instance[0].id, alicloud_instance.instance[1].id]
#         port       = 80
#         weight     = 100
#     }
# }

resource "alicloud_slb_backend_server" "default" {
  load_balancer_id = alicloud_slb_load_balancer.default.id

  backend_servers {
    server_id = alicloud_instance.instance[0].id
    weight    = 50
  }

  backend_servers {
    server_id = alicloud_instance.instance[1].id
    weight    = 50
  }
}

resource "alicloud_slb_listener" "default" {
  load_balancer_id    = alicloud_slb_load_balancer.default.id
  backend_port        = 80
  frontend_port       = 80
  protocol            = "http"
  bandwidth           = 10
  sticky_session      = "on"
  sticky_session_type = "insert"
  cookie_timeout      = 86400
  cookie              = "testslblistenercookie"
  # health_check              = "on"
  # health_check_domain       = "ali.com"
  # health_check_uri          = "/cons"
  # health_check_connect_port = 80
  # healthy_threshold         = 8
  # unhealthy_threshold       = 8
  # health_check_timeout      = 8
  # health_check_interval     = 5
  # health_check_http_code    = "http_2xx,http_3xx"
  x_forwarded_for {
    retrive_slb_ip = true
    retrive_slb_id = true
  }
  # acl_status      = "on"
  # acl_type        = "white"
  # acl_id          = alicloud_slb_acl.default.id
  request_timeout = 80
  idle_timeout    = 30
}

# resource "alicloud_slb_acl" "default" {
#     name       = "slb-acl-${var.name}"
#     ip_version = "ipv4"
#     entry_list {
#         entry   = "10.10.10.0/24"
#         comment = "first"
#     }
#     entry_list {
#         entry   = "168.10.10.0/24"
#         comment = "second"
#     }
# }