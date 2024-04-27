# VPC required to be created.
data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "ULTRA"
    workspaces = {
      name = "networking-layer"
    }
  }
}

# EKS Cluster required to be created.
data "terraform_remote_state" "eks" {
  backend = "remote"
  config = {
    organization = "ULTRA"
    workspaces = {
      name = "eks-cluster-infrastructure"
    }
  }
}


