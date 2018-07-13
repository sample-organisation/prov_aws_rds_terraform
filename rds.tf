provider "aws" {
  access_key  = "${var.aws_access_key_id}"
  secret_key  = "${var.aws_secret_access_key}"
  region      = "${var.aws_region}"
}

resource "aws_db_subnet_group" "demo_postgres_subnet_group" {
  name       = "demo-postgres-subnet-group"
  subnet_ids = ["${var.vpc_public_sn_id}", "${var.vpc_private_sn_id}"]
}

resource "aws_db_instance" "demo_postgres_db" {
  identifier           = "demo-postgres"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "9.6"
  instance_class       = "db.t2.micro"
  parameter_group_name = "default.postgres9.6"
  skip_final_snapshot  = true
  apply_immediately    = true
  db_subnet_group_name = "${aws_db_subnet_group.demo_postgres_subnet_group.name}"
  vpc_security_group_ids = ["${var.vpc_private_sg_id}"]
  multi_az             = false
  name                 = "${var.postgres_db_name}"
  username             = "${var.postgres_db_username}"
  password             = "${var.postgres_db_password}"
}

output "engine" {
  value = "${aws_db_instance.demo_postgres_db.engine}"
}

output "engine_version" {
  value = "${aws_db_instance.demo_postgres_db.engine_version}"
}

output "endpoint" {
  value = "${aws_db_instance.demo_postgres_db.endpoint}"
}

output "port" {
  value = "${aws_db_instance.demo_postgres_db.port}"
}

output "db_name" {
  value = "${aws_db_instance.demo_postgres_db.name}"
}

output "db_user" {
  value = "${aws_db_instance.demo_postgres_db.username}"
}
