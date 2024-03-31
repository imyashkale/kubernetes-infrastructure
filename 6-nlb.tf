resource "kubernetes_service_v1" "nlb" {
  metadata {
    name = "nlb"
    annotations = {
      // Launches the Network Load Balancer
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.app.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
