# Kubernetes Service Manifest (Type: Load Balancer)
resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name      = local.name
    namespace = "argocd"
    annotations = {
      "alb.ingress.kubernetes.io/load-balancer-name"           = "${local.name}"
      "alb.ingress.kubernetes.io/scheme"                       = "internet-facing"
      "alb.ingress.kubernetes.io/healthcheck-protocol"         = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-port"             = "traffic-port"
      "alb.ingress.kubernetes.io/healthcheck-path"             = "/"
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = 5
      "alb.ingress.kubernetes.io/success-codes"                = 200
      "alb.ingress.kubernetes.io/healthy-threshold-count"      = 2
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"    = 2

      "alb.ingress.kubernetes.io/listen-ports"    = jsonencode([{ "HTTPS" = 443 }, { "HTTP" = 80 }])
      "alb.ingress.kubernetes.io/certificate-arn" = "${aws_acm_certificate.acm_cert.arn}"
      "alb.ingress.kubernetes.io/ssl-redirect"    = 443
    }
  }

  spec {
    ingress_class_name = "aws-ingress-class" # Ingress Class     
    rule {
      http {
        path {
          backend {
            service {
              name = "argocd-server"
              port {
                number = 80
              }
            }
          }
          path      = "/argocd"
          path_type = "Prefix"
        }
      }
    }
    default_backend {
      service {
        name = "argocd-server"
        port {
          number = 80
        }
      }
    }
  }
}




