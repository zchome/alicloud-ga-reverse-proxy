variable "name" {
  type        = string
  default     = "rp"
  description = "The name of reverse proxy."
}

variable "resource_group_id" {
  type        = string
  description = "The resource group of reverse proxy."
}

variable "vpc_id" {
  type        = string
  description = "The vpc id of reverse proxy."
}

variable "vswitch_id" {
  type        = string
  description = "The vswitch id of reverse proxy."
}

variable "availability_zone" {
  type        = string
  description = "The az of reverse proxy server."
}

variable "instance_type" {
  type        = string
  default     = "ecs.t6-c1m1.large"
  description = "The instance type of reverse proxy server."
}

variable "image_id" {
  type        = string
  default     = "aliyun_3_x64_20G_alibase_20210910.vhd"
  description = "The image of reverse proxy server."
}

variable "key_name" {
  type        = string
  description = "The root account key name."
}

