resource "kubernetes_manifest" "argocd" {

  for_each = {
    for app in var.argocd_apps : app.name => app
  }

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "${each.value.name}"
      namespace = kubernetes_namespace_v1.argocd.metadata[0].name
    }
    spec = {
      project = each.value.project
      source = {
        repoURL        = each.value.repoURL
        targetRevision = each.value.targetRevision
        path           = each.value.path
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
  
  depends_on = [helm_release.argocd]
}
