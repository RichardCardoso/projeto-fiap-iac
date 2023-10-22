terraform {
  backend "remote" {
    organization = "projeto-fiap-64"

    workspaces {
      name = "projeto-fiap-iac-infra"
    }
  }
}

provider "aws" {
  region = var.region
}


# eks cluster data
data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

