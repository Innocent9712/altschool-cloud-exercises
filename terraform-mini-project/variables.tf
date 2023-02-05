# variable "aws_subnets" {
#   type = list(string)
#   description = "A list of subnets that are used to deploy the VMs"
#   default = ["subnet-0a1b2c3d4e5f6g7h8", "subnet-0a1b2c3d4e5f6g7h9"]
# }

variable "subnets" {
  description = "list of subnets to create"
   type = map
   default = {
      sub-1 = {
         az = "use1-az5"
         cidr = "10.0.1.0/24"
         name = "public-subnet-01"
      }
      sub-2 = {
         az = "use1-az4"
         cidr = "10.0.2.0/24"
         name = "public-subnet-02"
      }
   }
}

variable "profile" {
  description = "AWS Profile to be used to configure AWS"
  type = string
  nullable = false
}

variable "ubuntu_ami" {
  description = "The AMI ID of the Ubuntu 22.04 LTS image"
  type = string
}

variable "certificate_arn" {
  description = "https certificate for my domain"
  type = string
  nullable = false
  sensitive = true
}

variable "domain_name" {
  description = "My custom domain name"
  type = string
  default = null
}

variable "sub_domain" {
  description = "My custom sub domain name"
  type = string
  default = null
}

variable "instance_type" {
  description = "instance type to use"
  type = string
  default = "t2.micro"
}

variable "ssh_key" {
  description = "ssh key for remote connection to ec2 instance"
  type = string
  default = "innocent-HP-EliteBook-x360-1030-G2"
  sensitive = true
}

variable "ansible_hosts" {
  description = "file path for ansible hosts"
  type = string
  nullable = false
  default = "ansible/hosts"
}

variable "tf_state_bucket" {
  description = "Remote terraform state AWS Bucket"
  type = string
  nullable = false
  sensitive = true
}

variable "tf_state_table" {
  description = "DynamoDB table for performing state locking"
  type = string
  nullable = false
  sensitive = true
}