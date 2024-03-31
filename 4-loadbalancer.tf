resource "kubernetes_service_v1" "lb" {

  metadata {
    name = "lb"
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
