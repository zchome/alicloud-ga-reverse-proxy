variable "name" {
  type        = string
  default     = "vpn"
  description = "The name of vpn resources."
}

variable "resource_group_id" {
  type        = string
  description = "The resource group of vpn resources."
}

variable "vpc_id" {
  type        = string
  description = "The vpc id of vpn ecs resources."
}

variable "vswitch_id" {
  type        = string
  description = "The vswitch id of vpn ecs servers."
}

variable "availability_zone" {
  type        = string
  description = "The az of vpn ecs servers."
}

variable "instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "The instance type of vpn ecs servers."
}

variable "image_id" {
  type        = string
  default     = "aliyun_3_x64_20G_alibase_20210910.vhd"
  description = "The image of vpn ecs servers."
}

variable "key_name" {
  type        = string
  description = "The root account key name."
}

