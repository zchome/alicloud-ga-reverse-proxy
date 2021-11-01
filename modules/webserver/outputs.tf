output "slb_public_ip" {
  value       = alicloud_slb_load_balancer.default.address
  description = "The generated slb public ip."
}

output "ecs_public_ip" {
  value       = alicloud_instance.instance.*.public_ip
  description = "The generated ecs public ip."
}