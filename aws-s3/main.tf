terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "leo-bucket" {
  bucket = "leo-s3-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.leo-bucket.bucket
  source = "./myfile.txt"
  key    = "mydata.txt"

}

output "rand_id" {
  value = random_id.rand_id.hex
}