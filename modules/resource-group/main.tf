# Resource Group
resource "alicloud_resource_manager_resource_group" "default" {
  resource_group_name = "rg-${var.name}"
  display_name        = var.name
}