# Kubernetes Deployment Manifest
resource "kubernetes_deployment_v1" "myapp3" {
  metadata {
    name = "app3-nginx-deployment"
    labels = {
      app = "app3-nginx"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "app3-nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "app3-nginx"
        }
      }

      spec {
        container {
          image = "stacksimplify/kubenginx:1.0.0"
          name  = "app3-nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}


resource "kubernetes_service_v1" "myapp3_np_service" {
  metadata {
    name = "app3-nginx-nodeport-service"
    annotations = {
      #Important Note:  Need to add health check path annotations in service level if we are planning to use multiple targets in a load balancer    
      #"alb.ingress.kubernetes.io/healthcheck-path" = "/index.html"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp3.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}


# Kubernetes Service Manifest (Type: Load Balancer)
resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name = local.name
    annotations = {
      # Load Balancer Name
      "alb.ingress.kubernetes.io/load-balancer-name" = "${local.name}"
      # Ingress Core Settings
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      # Health Check Settings
      "alb.ingress.kubernetes.io/healthcheck-protocol" = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-port"     = "traffic-port"
      #Important Note:  Need to add health check path annotations in service level if we are planning to use multiple targets in a load balancer    
      "alb.ingress.kubernetes.io/healthcheck-path"             = "/index.html"
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = 5
      "alb.ingress.kubernetes.io/success-codes"                = 200
      "alb.ingress.kubernetes.io/healthy-threshold-count"      = 2
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"    = 2
    }
  }

  spec {
    ingress_class_name = "aws-ingress-class" # Ingress Class            
    default_backend {
      service {
        name = kubernetes_service_v1.myapp3_np_service.metadata[0].name
        port {
          number = 80
        }
      }
    }
  }
}
