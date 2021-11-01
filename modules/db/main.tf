# Security Group
resource "alicloud_security_group" "db_group" {
  name        = "sg-db-${var.name}"
  description = "${var.name} db security group"
  vpc_id      = var.vpc_id

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
}

# Security Group Rule
resource "alicloud_security_group_rule" "allow_internal" {
  security_group_id = alicloud_security_group.db_group.id
  nic_type          = "intranet"
  type              = "ingress"
  policy            = "accept"
  port_range        = "1/65535"
  ip_protocol       = "tcp"
  priority          = "50"
  cidr_ip           = var.vswitch_server_cidr
}

# DB instance
resource "alicloud_db_instance" "instance" {
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_name        = "db-${var.name}"
  instance_type        = var.db_instance_type
  instance_charge_type = "Postpaid"
  instance_storage     = var.db_instance_storage
  vswitch_id           = var.vswitch_db_id

  resource_group_id = var.resource_group_id
  tags = {
    poc = var.name
  }
}

# DB account
resource "alicloud_db_account" "account" {
  db_instance_id   = alicloud_db_instance.instance.id
  account_name     = var.db_account_name
  account_password = var.db_account_password
}

# DB database
resource "alicloud_db_database" "db" {
  instance_id   = alicloud_db_instance.instance.id
  name          = var.db_name
  character_set = var.db_character_set
}

# DB privilege
resource "alicloud_db_account_privilege" "privilege" {
  instance_id  = alicloud_db_instance.instance.id
  account_name = alicloud_db_account.account.name
  db_names     = [alicloud_db_database.db.name]
  privilege    = "DBOwner"
}

# DB connection prefix
resource "alicloud_db_connection" "connection" {
  instance_id       = alicloud_db_instance.instance.id
  connection_prefix = var.db_connection_prefix
}