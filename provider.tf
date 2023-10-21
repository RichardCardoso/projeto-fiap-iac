terraform {
  cloud {
      organization = projeto-fiap-64"
      workspaces {
        name = "projeto-fiap-iac-infra"
      }
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
  }
}

provider "aws" {
  region = var.region
}
