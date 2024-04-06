resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd-${var.application_name}-${var.enviroment}"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.27.3"
  namespace  = "argocd-${var.application_name}-${var.enviroment}"
  timeout    = "1200"
  values     = [templatefile("./argocd/install.yaml", {})]
}