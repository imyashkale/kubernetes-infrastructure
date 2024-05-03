variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "application_name" {
  description = "Application Name"
  type        = string
}

variable "enviroment" {
  description = "Application Enviroment"
  type        = string
}

variable "github_client_id" {
  description = "The GitHub Client Id"
  type        = string
  sensitive   = true
}

variable "github_client_secret" {
  description = "The GitHub Client Secret"
  type        = string
  sensitive   = true
}

variable "github_token" {
  description = "The GitHub Token"
  type        = string
  sensitive   = true
}

variable "backstage_db_password" {
  description = "The Backstage DB Password"
  type        = string
  sensitive   = true
}

variable "backstage_db_user" {
  description = "The Backstage DB User"
  type        = string
  sensitive   = true
}

variable "backend_secret" {
  description = "The Backend Secret"
  type        = string
  sensitive   = true
}
variable "argocd_apps" {
  description = "ArgoCD Application Configurations"
  type        = list(map(string))
  default = [
    {
      name           = "homepage"
      project        = "default"
      repoURL        = "https://github.com/imyashkale/argocd-applications.git"
      targetRevision = "HEAD"
      path           = "homepage"
    },
    {
      name           = "backstage"
      project        = "default"
      repoURL        = "https://github.com/imyashkale/argocd-applications.git"
      targetRevision = "HEAD"
      path           = "backstage"
    }
  ]
}
