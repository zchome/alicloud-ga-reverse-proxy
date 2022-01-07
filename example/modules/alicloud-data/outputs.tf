output "alicloud_avalable_zone_id" {
    description = "A list of the avalability zone ids."
    value = data.alicloud_zones.default.zones[0].id
}

output "alicloud_avalable_zone_2_id" {
    description = "A list of the avalability zone ids."
    value = data.alicloud_zones.default.zones[1].id
}