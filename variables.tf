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

variable "argocd_apps" {
  description = "ArgoCD Application Configurations"
  type        = list(map(string))
  default = [
    {
      name           = "homepage"
      project        = "ultra"
      repoURL        = "https://github.com/imyashkale/homepage-k8s-configs.git"
      targetRevision = "HEAD"
      path           = "dev"
    }
  ]
}
