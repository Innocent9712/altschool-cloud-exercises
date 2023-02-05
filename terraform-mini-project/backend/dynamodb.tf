# module "dynamodb_table" {
#   source   = "terraform-aws-modules/dynamodb-table/aws"

#   name     = "terraform-state-lock-dynamo"
#   hash_key = "id"
#   write_capacity = 20
#   read_capacity = 20

#   attributes = [
#     {
#       name = "id"
#       type = "S"
#     }
#   ]

#   tags = {
#     Terraform   = "true"
#     Environment = "staging"
#   }
# }

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
    name           = "terraform_state"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}