#resource "local_file" "distros" {
#  filename = "/tmp/nix.txt"
#  content = "I Love Linux distros like Ubuntu. Debian, RHEL, Rocky Linux & Kali Linux etc"
#}


terraform {
  backend "s3" {
    bucket = "prpdbl-bucket1"
    key = "terraform/backend"
    region = "us-east-1"
  }
}

locals {
  env_name = "sandbox"
  aws_region = "us-east-1"
  k8s_cluster_name = "ms-cluster"
}

# Network Configuration

# EKS Configuration

# GitOps Configuration
