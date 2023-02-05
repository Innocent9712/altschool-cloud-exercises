 terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-east-1"
    profile = "iaminnocent"
}
# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"

#   bucket = "my-tf-state-bucket-27012023"
#   acl    = "private"

#   versioning = {
#     enabled = true
#   }
# }

# resource "aws_s3_bucket" "tf_course" {
    
#     bucket = "my-tf-state-bucket-27012023"
#     acl = "private"
# }

resource "aws_s3_bucket" "state_bucket" {
    bucket = "my-tf-state-bucket-27012023"

    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket = aws_s3_bucket.state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket_encryption" {
  bucket = aws_s3_bucket.state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}
