provider "aws" {
  access_key  = "${var.aws_access_key_id}"
  secret_key  = "${var.aws_secret_access_key}"
  region      = "${var.aws_region}"
}

resource "aws_db_instance" "demo_postgres_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  parameter_group_name = "default.postgres10.3"
  # Use Shippable secure KV pair for storing this
  name                 = "demodb"
  username             = "foo"
  password             = "foobarbaz"
}
