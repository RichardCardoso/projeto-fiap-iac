terraform {
  cloud {
    organization = "projeto-fiap-64"

    workspaces {
      name = "projeto-fiap-iac-infra"
    }
  }
}

provider "aws" {
  region = var.region
}
