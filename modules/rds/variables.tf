variable "db_name" {
  description = "Nome do banco de dados - padrão fiap_projeto"
  type        = string
}

variable "db_username" {
  description = "Nome de usuário do banco de dados - padrão fiap_user"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados - padrão fiap_course1234"
  type        = string
}

variable "db_cluster_name" {
  description = "Nome do banco no rds - padrão projeto-fiap-db"
  type        = string
}

variable "private_subnet_1a" {}

variable "private_subnet_1b" {}

variable "eks_subnet_public_1b" {}      # remover antes da entrega, apenas para testes

variable "eks_subnet_public_1a" {}      # remover antes da entrega, apenas para testes

variable "vpc_id" {}