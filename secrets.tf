resource "kubernetes_namespace_v1" "backstage" {
  metadata {
    name = "backstage"
  }
}

resource "kubernetes_secret_v1" "postgres-secrets" {
  metadata {
    name      = "postgres-secrets"
    namespace = kubernetes_namespace_v1.backstage.metadata[0].name
  }

  type = "Opaque"
  data = {
    POSTGRES_USER     = var.backstage_db_user
    POSTGRES_PASSWORD = var.backstage_db_password
  }
}

resource "kubernetes_secret_v1" "backstage" {
  metadata {
    name      = "backstage-secrets"
    namespace = kubernetes_namespace_v1.backstage.metadata[0].name
  }
  type = "Opaque"

  data = {
    GITHUB_TOKEN              = var.github_token
    AUTH_GITHUB_CLIENT_ID     = var.github_client_id
    AUTH_GITHUB_CLIENT_SECRET = var.github_client_secret
    BACKEND_SECRET            = var.backend_secret
  }

}

resource "null_resource" "secrets" {
  depends_on = [
    kubernetes_secret_v1.backstage,
    kubernetes_secret_v1.postgres-secrets
  ]
}
