terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

data "aws_ami" "name" {
    most_recent = true
    owners = ["amazon"]
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

resource "aws_instance" "myserver" {
#   ami           = "ami-0f5d42f0ba3ba0328"
  ami = data.aws_ami.name.id
  instance_type = "t4g.nano"

  tags = {
    Name = "Leo-Server-ds"
  }
}