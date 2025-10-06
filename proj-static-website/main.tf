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

resource "aws_s3_bucket" "leo-portfolio-bucket" {
  bucket = "leo-portfolio-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "leo-portfolio-bucket" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.id
  policy = jsonencode(
    {
    Version = "2012-10-17",		 	 	 
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.leo-portfolio-bucket.id}/*"
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "leo-portfolio-bucket" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.bucket
  source = "./index.html"
  key    = "index.html"
  content_type = "text/html"

}

resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.bucket
  source = "./css/style.css"
  key    = "style.css"
  content_type = "text/css"

}

resource "aws_s3_object" "Profile_pic_Leo_jpg" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.bucket
  source = "./images/Profile_pic_Leo.jpg"
  key    = "Profile_pic_Leo.jpg"
  content_type = "image/jpg"

}

resource "aws_s3_object" "script_js" {
  bucket = aws_s3_bucket.leo-portfolio-bucket.bucket
  source = "./js/script.js"
  key    = "script.js"
  content_type = "text/js"

}
output "rand_id" {
  value = aws_s3_bucket_website_configuration.leo-portfolio-bucket.website_endpoint 
}