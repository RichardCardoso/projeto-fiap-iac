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