resource "kubernetes_deployment_v1" "app" {
  metadata {
    name = "app"
    labels = {
      app = "app"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "app"
      }
    }
    template {
      metadata {
        labels = {
          app = "app"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }

}
