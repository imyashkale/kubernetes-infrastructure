resource "kubernetes_manifest" "ultra" {

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "${local.name}"
      namespace = "argocd"
    }
    spec = {
      project = "default"

      source = {
        repoURL        = "https://github.com/imyashkale/terraform-k8s-services.git"
        targetRevision = "HEAD"
        path           = "dev"
        directory = {
          recurse : true
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "apps"
      }
      syncPolicy = {
        syncOptions = ["CreateNamespace=true"]

        automated = {
          selfHeal = true
          prune    = true
        }
      }
    }
  }
}
