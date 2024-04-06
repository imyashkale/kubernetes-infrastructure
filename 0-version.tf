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

  backend "s3" {
    bucket = "infrastructure-statefile"
    key    = "infrastructure/k8-microservices/statefile.tfstate"
    region = "ap-south-1"

    dynamodb_table = "infrastructure-state-lock"
  }
}


