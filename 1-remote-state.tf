# VPC required to be created.
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "infrastructure-statefile"
    key    = "infrastructure/vpc/statefile"
    region = "ap-south-1"
  }
}

# EKS Cluster required to be created.
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "infrastructure-statefile"
    key    = "infrastructure/eks/statefile"
    region = "ap-south-1"
  }
}


