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
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.87.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
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

provider "hcp" {
  # Configuration options
}


