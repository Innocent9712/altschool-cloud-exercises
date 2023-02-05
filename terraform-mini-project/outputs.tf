output "subnets" {
  description = "List of Subnets from data"
  value      = data.aws_subnets.selected.ids
}

output "ami" {
    description = "AMI id of ubuntu 22.04"
    value = data.aws_ami_ids.ubuntu.ids[0]
}

# output "instances" {
#     description = "all instances created"
#     value = aws_instance.web-servers
# }

output "sg-id" {
  description = "security group id"
  value = data.aws_security_groups.sg.ids
}

output "alb-dns-name" {
    description = "get the dns name for load balancer"
    value = aws_lb.alb.dns_name
}


# output "subnets_a" {
#   value = aws_subnet.main-subnets
# }