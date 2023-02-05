# Create an Application Load Balancer
resource "aws_lb" "alb" {
  name               = "web-server-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_and_https.id]
  subnets            = setunion(data.aws_subnets.selected.ids, [])
#   vpc_id             = data.aws_vpc.overlord_vpc.id


  tags = {
    Environment = "production"
  }
}

# Create security group to all http and https tcp traffic into load balancer
resource "aws_security_group" "allow_http_and_https" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.overlord_vpc.id

  ingress {
    description      = "TLS  secured from anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# Create target group pointing to instances for
# the ALB to share requests to
resource "aws_lb_target_group" "alb-tg" {
  name        = "web-server-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.overlord_vpc.id
  health_check {
    path = "/"
    port = "80"
    protocol = "HTTP"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 300
    matcher = "200"
  }
}

# Attach the instances to the target group
resource "aws_lb_target_group_attachment" "attach_instances" {
  count = length(aws_instance.web-servers)
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.web-servers[count.index]["id"]
  port             = 80
}

# Create an HTTP listener for the ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    type             = "forward"
  }
  depends_on = [
    aws_lb_target_group.alb-tg
  ]
}

# Create an HTTPS listner for the ALB
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.certificate_arn}"
#   certificate_arn = aws_acm_certificate.ssl.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

# Redirect http requests to my subdomain into https requests
resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  
  action {
    type             = "redirect"
    redirect {
      host    = "#{host}"
      path    = "/#{path}"
      port    = "443"
      protocol= "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["${var.sub_domain}"]
    }
  }
}








# resource "aws_lb_listener_rule" "lb-tg-rule" {
#   listener_arn = aws_lb_listener.https_listener.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb-tg.arn
#     protocol         = "HTTP"
#   }
# }
