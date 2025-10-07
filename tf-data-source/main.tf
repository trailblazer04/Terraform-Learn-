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

# security group
data "aws_security_group" "name-sg" {
  tags = {
    mywebserver = "http"
  }
}

output "security_group" {
  value = data.aws_security_group.name-sg.id
}

#VPC Id 
data "aws_vpc" "name" {
  tags = {
    Name = "my_vpc_leo"
  }
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}

# AZ
data "aws_availability_zones" "names" {
  state = "available"
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}

# to get the account details
data "aws_caller_identity" "name" {
  
}

output "caller_info" {
  value = data.aws_caller_identity.name
}

# to get the region
data "aws_region" "name" {
  
}

output "region_name" {
  value = data.aws_region.name
}
# output "aws_ami" {
#   value = data.aws_ami.name.id
# }

resource "aws_instance" "myserver" {
#   ami           = "ami-0f5d42f0ba3ba0328"
  ami = data.aws_ami.name.id
  instance_type = "t4g.nano"

  tags = {
    Name = "Leo-Server-ds"
  }
}