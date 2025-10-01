terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

# variable "type" {

# }

resource "aws_instance" "myserver" {
  ami           = "ami-0f5d42f0ba3ba0328"
  instance_type = "t4g.nano"

  tags = {
    Name = "Leo-Server"
  }
}