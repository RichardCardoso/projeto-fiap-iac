resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
}