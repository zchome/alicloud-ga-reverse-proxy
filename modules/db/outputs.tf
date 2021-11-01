output "db_connection_string" {
  value       = alicloud_db_instance.instance.connection_string
  description = "The db instance connection string."
}