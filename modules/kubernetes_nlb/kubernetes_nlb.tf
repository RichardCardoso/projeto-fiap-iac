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

resource "kubernetes_service" "lb_projetofiap" {
  metadata {
    name = "lb-app-projetofiap"
    labels = {
      app = "lb-app-projetofiap"
    }
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
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

data "aws_lb" "this" {
  name = regex("^(?P<name>.+)-.+\\.elb\\..+\\.amazonaws\\.com", kubernetes_service.lb_projetofiap.status.0.load_balancer.0.ingress.0.hostname)["name"]
}

output "nlb_arn" {
  description = "The ARN of the Kubernetes NLB"
  value       = data.aws_lb.this.arn
}

output "nlb_dns_name" {
  description = "The DNS name of the Kubernetes NLB"
  value       = kubernetes_service.lb_projetofiap.status.0.load_balancer.0.ingress.0.hostname
}