output "ecs_public_ip" {
  value       = alicloud_instance.instance.public_ip
  description = "The generated ecs public ip."
}

output "ecs_2_public_ip" {
  value       = alicloud_instance.instance_2.public_ip
  description = "The generated 2nd ecs public ip."
}

output "slb_public_ip" {
  value       = alicloud_eip_address.slb.ip_address
  # value       = alicloud_slb_load_balancer.default.address
  description = "The generated slb public ip."
}