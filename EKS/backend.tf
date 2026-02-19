terraform {
  backend "s3" {
    bucket = "ci-cd-terraform-eks-bkt"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}