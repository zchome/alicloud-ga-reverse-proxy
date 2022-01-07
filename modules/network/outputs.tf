output "vpc_id" {
  value       = alicloud_vpc.vpc.id
  description = "The generated vpc id."
}

output "vswitch_server_id" {
  value       = alicloud_vswitch.vswitch_server.id
  description = "The generated vswitch server id."
}

output "vswitch_server_2_id" {
  value       = alicloud_vswitch.vswitch_server_2.id
  description = "The generated 2nd vswitch server id."
}

# output "vswitch_db_id" {
#   value       = alicloud_vswitch.vswitch_db.id
#   description = "The generated vswitch db id."
# }