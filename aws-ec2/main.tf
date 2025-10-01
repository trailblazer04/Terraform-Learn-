terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
    ami = "ami-0b9093ea00a0fed92"
    instance_type = "t4g.small"

    tags = {
        Name = "Leo-Server"
    }
}