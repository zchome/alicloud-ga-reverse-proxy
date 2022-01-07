variable "name" {
  type        = string
  default     = "ga"
  description = "The name of global accelerator."
}

variable "bandwidth_type" {
  type        = string
  default     = "Advanced"
  description = "The bandwidth type of global accelerator."
}

variable "bandwidth" {
  type        = string
  default     = "5"
  description = "The bandwidth(Mbps) of global accelerator."
}

variable "ga_http_protocol" {
  type        = string
  default     = "TCP"
  description = "The HTTP listener protocol."
}

variable "accelerate_region_id" {
  type        = string
  default     = "cn-hongkong"
  description = "The accelerate region of global accelerator."
}

variable "endpoint_group_region" {
  type        = string
  description = "The endpoint region of global accelerator."
}

variable "endpoint_type" {
  type        = string
  default     = "PublicIp"
  description = "The endpoint id address of global accelerator."
}

variable "endpoint_ip_address" {
  type        = string
  description = "The endpoint id address of global accelerator."
}

