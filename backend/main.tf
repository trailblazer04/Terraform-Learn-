terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
  backend "s3" {
    bucket = "leo-s3-bucket-25fe974013d436ab"
    key = "backend.tfstate"
    region = "ap-south-1"
  }
}


provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

# variable "type" {

# }

resource "aws_instance" "myserver" {
  ami           = "ami-0f5d42f0ba3ba0328"
  instance_type = "t4g.nano"

  tags = {
    Name = "Leo-Server1"
  }
}