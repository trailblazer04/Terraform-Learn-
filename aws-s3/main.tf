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

resource "aws_s3_bucket" "leo-bucket" {
  bucket = "leo-s3-bucket-1234"
}