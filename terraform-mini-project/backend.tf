# Connecting to remote s3 backend
terraform {
  backend "s3" {
    encrypt = true
    bucket = "my-tf-state-bucket-27012023"
    dynamodb_table = "terraform_state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
