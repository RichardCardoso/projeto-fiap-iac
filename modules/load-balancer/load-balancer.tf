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

resource "kubernetes_service" "lb_app_projetofiap" {
  metadata {
    name = "lb-app-projetofiap"
    labels = {
      app = "lb-app-projetofiap"
    }
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
  }

  spec {
    port {
      port        = 80
      target_port = 8080
    }

    selector = {
      app = "projetofiap-deployment"
    }

    type = "LoadBalancer"
  }
}
