# Describe necessary providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.3"
    }
  }
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-east-1"
    profile = "${var.profile}"
}

provider "local" {
  # Configuration options
}

# Created a new account so I have to run the vpc.tf file first
# Since it'll be easier that way than actually rewriting all my resources
# Get overlord VPC details
data "aws_vpc" "overlord_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "overlord"
  }
  depends_on = [
    aws_vpc.overlord
  ]
}

# Get 2 subnets from overlord VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.overlord_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["public-subnet-01", "public-subnet-02"] # insert values here
  }
  depends_on = [
    aws_subnet.main-subnets
  ]
}

# Get ubuntu 22.04 free tier AMI
data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy*-*-amd64-server-*20230115"]
  }
}

# Get existing security group that allows http, https, and
# ssh on the overlord VPC
data "aws_security_groups" "sg" {
  filter {
    name   = "group-name"
    values = ["*big-3"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.overlord_vpc.id]
  }
  depends_on = [
    aws_security_group.instance_sg
  ]
}
