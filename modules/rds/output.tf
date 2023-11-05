output "db_instance_endpoint" {
  description = "Endpoint de conexão para a insância do RDS"
  value = aws_db_instance.default.endpoint
}