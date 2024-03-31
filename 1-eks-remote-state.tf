data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "infrastructure-statefile"
    key    = "infrastructure/eks/statefile"
    region = "ap-south-1"
  }
}