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

  cloud {
    organization = "ULTRA"
    workspaces {
      name = "kubernetes-infrastructure"
    }
  }
}

provider "hcp" {
  # Configuration options
}
provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "eks" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

locals {
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data
  )
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = local.cluster_ca_certificate
  token                  = data.aws_eks_cluster_auth.cluster.token
}



# VPC required to be created.
data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "ULTRA"
    workspaces = {
      name = "network-infrastructure"
    }
  }
}

# EKS Cluster required to be created.
data "terraform_remote_state" "eks" {
  backend = "remote"
  config = {
    organization = "ULTRA"
    workspaces = {
      name = "cluster-infrastructure"
    }
  }
}
