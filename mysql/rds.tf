provider "aws" {
  access_key  = "${var.aws_access_key_id}"
  secret_key  = "${var.aws_secret_access_key}"
  region      = "${var.aws_region}"
}

resource "aws_db_subnet_group" "demo_mysql_subnet_group" {
  name       = "demo-mysql-subnet-group"
  subnet_ids = ["${var.vpc_public_sn_id}", "${var.vpc_private_sn_id}"]
}

resource "aws_db_instance" "demo_mysql_db" {
  identifier           = "demo-mysql"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  db_subnet_group_name = "${aws_db_subnet_group.demo_mysql_subnet_group.name}"
  vpc_security_group_ids = ["${var.vpc_private_sg_id}"]
  multi_az             = false
  name                 = "${var.mysql_db_name}"
  username             = "${var.mysql_db_username}"
  password             = "${var.mysql_db_password}"
}

output "engine" {
  value = "${aws_db_instance.demo_mysql_db.engine}"
}

output "engine_version" {
  value = "${aws_db_instance.demo_mysql_db.engine_version}"
}

output "endpoint" {
  value = "${aws_db_instance.demo_mysql_db.endpoint}"
}

output "port" {
  value = "${aws_db_instance.demo_mysql_db.port}"
}

output "db_name" {
  value = "${aws_db_instance.demo_mysql_db.name}"
}

output "db_user" {
  value = "${aws_db_instance.demo_mysql_db.username}"
}
