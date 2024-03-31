resource "kubernetes_service_v1" "nodeport" {
  metadata {
    name = "app-nodeport"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.app.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
      node_port   = 31280
    }
    type = "NodePort"
  }
}
