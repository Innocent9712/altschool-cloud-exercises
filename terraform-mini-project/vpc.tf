resource "aws_vpc" "overlord" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "overlord"
  }
}

# resource "aws_subnet" "public-subnet-01" {
#   vpc_id            = aws_vpc.overlord.id
#   cidr_block        = "10.0.1.0/24"
#     availability_zone = "us-east-1a"

#   tags = {
#     Name = "public-subnet-01"
#   }
# }

resource "aws_subnet" "main-subnets" {
  for_each = var.subnets
 
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = aws_vpc.overlord.id

  tags = {
    Name = "${each.value["name"]}"
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "big-3"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.overlord.id

  ingress {
    description      = "TCP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.overlord.cidr_block]
  }

    ingress {
    description      = "SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "big-3"
  }
}

resource "aws_internet_gateway" "overlord_gateway" {
  vpc_id = aws_vpc.overlord.id

  tags = {
    Name = "overlord_gateway"
  }
}

resource "aws_route" "ig_rule" {
  route_table_id          = aws_vpc.overlord.default_route_table_id
  destination_cidr_block   = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.overlord_gateway.id
}

resource "aws_route_table_association" "rt_association_to_subnets" {
  for_each = aws_subnet.main-subnets
  # subnet_id      = aws_subnet.public-subnet-01.id
  subnet_id      = each.value["id"]
  route_table_id = aws_vpc.overlord.default_route_table_id
}
