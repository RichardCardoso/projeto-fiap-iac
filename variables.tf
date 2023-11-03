variable "cluster_name" {
  default = "projeto-fiap"
}

variable "desired_size" {
  default = 1
}

variable "max_size" {
  default = 1
}

variable "min_size" {
  default = 1
}

variable "region" {
  default = "us-east-1"
}

variable "kubernetes_version" {
  default = 1.28
}

variable "lambda_name" {
  default = "projeto-fiap-authorizer"
}

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