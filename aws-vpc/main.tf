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
  region = "ap-south-1"
}

# Create a vpc
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc_leo"
    }
}

# Private subnet
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "private-subnet"
    }
  
}

# Public subnet
resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "public-subnet"
    }
}

# Internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Routing table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public-subnet.id
}

# create ec2 instance
resource "aws_instance" "myserver" {
  ami           = "ami-0f5d42f0ba3ba0328"
  instance_type = "t4g.nano"
  subnet_id = aws_subnet.public-subnet.id

  tags = {
    Name = "Leo-Server"
  }
}