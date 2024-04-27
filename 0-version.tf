terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.0"
    }
  }

  backend "remote" {
    cloud {
      organization = "ULTRA"
      workspaces {
        name = "kubernetes-infrastructure"
      }
    }
  }
}


