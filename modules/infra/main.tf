terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.1"
    }
  }
}



# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "${var.alb_name}-${var.env}"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet[*].id

    tags = {
    Name = "${var.alb_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

# Target Group for ALB
resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.tg_name}-${var.env}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.tg_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  tags = {
    Name = "yt-alb-listener"
    Student = "pangani"
    Env = var.env
  }
}
