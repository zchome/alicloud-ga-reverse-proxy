output "ga_id" {
  value       = alicloud_ga_accelerator.default.id
  description = "The generated ga id."
}

output "ga_accelerator_ips" {
  value       = alicloud_ga_ip_set.default.ip_address_list
  description = "The generated ga id."
}