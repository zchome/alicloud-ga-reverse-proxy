variable "name" {
  type        = string
  default     = "webserver"
  description = "The name of all resouces."
}

variable "resource_group_id" {
  type        = string
  description = "The resource group of all resouces."
}

variable "vpc_id" {
  type        = string
  description = "The vpc id of all resouces."
}

variable "vswitch_server_id" {
  type        = string
  description = "The vswitch id of servers."
}

variable "availability_zone" {
  type        = string
  description = "The az of servers."
}

variable "instance_type" {
  type        = string
  default     = "ecs.t6-c1m4.large"
  description = "The instance type of servers."
}

variable "image_id" {
  type        = string
  default     = "win2012r2_9600_x64_dtc_en-us_40G_alibase_20210916.vhd"
  description = "The image of servers."
}

variable "password" {
  type        = string
  description = "The ssh key path of servers."
}

variable "load_balancer_spec" {
  type        = string
  default     = "slb.s2.small"
  description = "The slb instance type."
}