variable "name" {
  type        = string
  default     = "vpc"
  description = "The name of vpc."
}

variable "vpc_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "The vpc cidr."
}

variable "vswitch_server_cidr" {
  type        = string
  default     = "172.16.0.0/24"
  description = "The servers vswitch cidr."
}

variable "vswitch_server_2_cidr" {
  type        = string
  default     = "172.16.1.0/24"
  description = "The 2nd servers vswitch cidr."
}

# variable "vswitch_db_cidr" {
#   type        = string
#   default     = "172.16.2.0/24"
#   description = "The db vswitch cidr."
# }

variable "resource_group_id" {
  type        = string
  description = "The resource group of vpc."
}

variable "availability_zone" {
  type        = string
  description = "The availability zone of vswitch."
}

variable "availability_zone_2" {
  type        = string
  description = "The availability zone of 2nd vswtich."
}