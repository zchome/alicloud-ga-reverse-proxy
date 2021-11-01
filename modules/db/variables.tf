variable "name" {
  type        = string
  default     = "db"
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

variable "vswitch_db_id" {
  type        = string
  description = "The vswitch id of db."
}

variable "vswitch_server_cidr" {
  type        = string
  description = "The server cidr."
}
variable "db_engine" {
  type        = string
  default     = "SQLServer"
  description = "The db engine."
}

variable "db_engine_version" {
  type        = string
  default     = "2016_web"
  description = "The db engine version."
}

variable "db_instance_type" {
  type        = string
  default     = "mssql.x2.medium.w1"
  description = "The db instance type."
}

variable "db_instance_storage" {
  type        = string
  default     = "20"
  description = "The db instance storage."
}

variable "db_character_set" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "The db character set."
}

variable "db_account_name" {
  type        = string
  description = "The db account name."
}

variable "db_account_password" {
  type        = string
  description = "The db account password."
}

variable "db_name" {
  type        = string
  description = "The db name."
}

variable "db_connection_prefix" {
  type        = string
  description = "The db connection prefix."
}