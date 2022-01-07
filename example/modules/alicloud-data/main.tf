# AZ 
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = ["VSwitch", "Slb", "Instance"]
}