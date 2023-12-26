#resource "local_file" "distros" {
#  filename = "/tmp/nix.txt"
#  content = "I Love Linux distros like Ubuntu. Debian, RHEL, Rocky Linux & Kali Linux etc"
#}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

provider "aws" {
  region = "us-east-1"
#  access_key = "${var.AWS_ACCESS_KEY_ID}"
#  secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
}

resource "aws_security_group" "project-iac-sg" {
  name = "IAC-Sec-Group"
  description = "IAC-Sec-Group"
  vpc_id = "vpc-03226c7780672b16d"

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
#    protocol = ""
    protocol        = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
#    protocol        = "-1"
    protocol        = "TCP"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "project-iac" {
#  ami = "ami-0c1bea58988a989155"
  ami = "ami-0759f51a90924c166"
  instance_type = "t2.micro"
  subnet_id = "subnet-0d70178f51032d9ac" #FFXsubnet2
  associate_public_ip_address = true
  key_name = "myseckey"


  vpc_security_group_ids = [
    aws_security_group.project-iac-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp3"
  }
  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.project-iac-sg ]
}


output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}


#terraform {
#  backend "s3" {
#    bucket = "prpdbl-bucket1"
#    key = "terraform/backend"
#    region = "us-east-1"
#  }
#}

#locals {
#  env_name = "sandbox"
#  aws_region = "us-east-1"
#  k8s_cluster_name = "ms-cluster"
#}

# Network Configuration ... 

# EKS Configuration

# GitOps Configuration
