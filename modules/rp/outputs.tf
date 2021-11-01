output "ecs_public_ip" {
  value       = alicloud_instance.instance.public_ip
  description = "The generated ecs public ip."
}