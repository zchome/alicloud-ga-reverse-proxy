# Global Accelerator
resource "alicloud_ga_accelerator" "default" {
  accelerator_name  = "ga-${var.name}"
  auto_use_coupon   = true
  duration          = 1
  spec              = "1"                 # 1 2 3 5 8 10 accordingly Small 1 - Medium 3
}

# Bandwidth
resource "alicloud_ga_bandwidth_package" "default" {
  bandwidth                 = "${var.bandwidth}"
  type                      = "Basic"                 # "Basic" "CrossDomain"
  bandwidth_type            = "${var.bandwidth_type}" # "Basic" "Advanced" "Enhanced"
  duration                  = 1                       # 1 month
  ratio                     = 30
  # payment_type              = "PayAsYouGo"            # "PayAsYouGo" "Subscription"
  # billing_type              = "PayBy95"               # "PayBy95" "PayByTraffic" # Not support
  auto_pay                  = true
  auto_use_coupon           = true
}

# Bandwidth Cross Border
resource "alicloud_ga_bandwidth_package" "china" {
  count                     = "${var.accelerate_region_id != "cn-hongkong" ? 1 : 0}"
  bandwidth                 = "${var.bandwidth}"
  type                      = "CrossDomain"         # "Basic" "CrossDomain"
  # bandwidth_type            = "${var.bandwidth_type}" # "Basic" "Advanced" "Enhanced"
  duration                  = 1                     # 1 month
  ratio                     = 30
  cbn_geographic_region_ida = "China-mainland"
  cbn_geographic_region_idb = "Global"
  payment_type              = "PayAsYouGo"          # "PayAsYouGo" "Subscription"
  billing_type              = "PayByTraffic"        # "PayBy95" "PayByTraffic"
  auto_pay                  = true
  auto_use_coupon           = true
}

# Attachment
resource "alicloud_ga_bandwidth_package_attachment" "default" {
  accelerator_id       = alicloud_ga_accelerator.default.id
  bandwidth_package_id = alicloud_ga_bandwidth_package.default.id
}

# GA Listener
resource "alicloud_ga_listener" "https" {
  depends_on     = [alicloud_ga_bandwidth_package_attachment.default]
  accelerator_id = alicloud_ga_accelerator.default.id
  protocol       = "TCP"
  name           = "HTTPS"
  port_ranges {
    from_port = 443
    to_port   = 443
  }
}

resource "alicloud_ga_listener" "http" {
  depends_on     = [alicloud_ga_bandwidth_package_attachment.default]
  accelerator_id = alicloud_ga_accelerator.default.id
  protocol       = "${var.ga_http_protocol != "HTTP" ? "TCP" : "HTTP"}"
  name           = "HTTP"
  port_ranges {
    from_port = 80
    to_port   = 80
  }
}

# # EIP
# resource "alicloud_eip_address" "default" {
#   bandwidth            = "5"
#   internet_charge_type = "PayByBandwidth"
# }

# Endpoints
resource "alicloud_ga_endpoint_group" "http" {
  endpoint_group_region = "${var.endpoint_group_region}"
  accelerator_id        = alicloud_ga_accelerator.default.id
  listener_id           = alicloud_ga_listener.http.id
  name                  = "${var.name}-end-http"
  endpoint_configurations {
    endpoint            = "${var.endpoint_ip_address}"
    type                = "${var.endpoint_type}"              # "Ip" "PublicIp" "ECS" "SLB" 
    weight              = "100"
  }
}

resource "alicloud_ga_endpoint_group" "https" {
  endpoint_group_region = "${var.endpoint_group_region}"
  accelerator_id        = alicloud_ga_accelerator.default.id
  listener_id           = alicloud_ga_listener.https.id
  name                  = "${var.name}-end-https"
  endpoint_configurations {
    endpoint            = "${var.endpoint_ip_address}" 
    type                = "${var.endpoint_type}"              # "Ip" "PublicIp" "ECS" "SLB" 
    weight              = "100"
  }
}

# Accelerate Region
resource "alicloud_ga_ip_set" "default" {
  depends_on           = [alicloud_ga_bandwidth_package_attachment.default]
  accelerate_region_id = "${var.accelerate_region_id}"
  bandwidth            = "${var.bandwidth}" 
  accelerator_id       = alicloud_ga_accelerator.default.id
}