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

