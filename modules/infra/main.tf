terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.1"
    }
  }
}



# Application Load Balancer
resource "aws_lb" "app-lb" {
  name               = "${var.alb_name}-${var.env}"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.sbn_1a_pub_id, var.sbn_1b_pub_id]

    tags = {
    Name = "${var.alb_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

# Target Group for ALB
resource "aws_lb_target_group" "alb-tg" {
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

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
  tags = {
    Name = "yt-alb-listener"
    Student = "pangani"
    Env = var.env
  }
}


resource "aws_instance" "web-1a" {
  ami             =  var.ami_website
  instance_type   = var.instance_type_website
  subnet_id       = var.sbn_1a_priv_id
  security_groups = [aws_security_group.sg-infra-website.id]
  tags = {
    Name = "ec2-ec1-1b-website-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

resource "aws_instance" "web-1b" {
  ami             =  var.ami_website
  instance_type   = var.instance_type_website
  subnet_id       = var.sbn_1b_priv_id
  security_groups = [aws_security_group.sg-infra-website.id]
  tags = {
    Name = "ec2-ec1-1b-website-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}


resource "aws_lb_target_group_attachment" "attach_1" {
  target_group_arn = aws_lb_target_group.alb-tg
  target_id        = aws_instance.web-1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_2" {
  target_group_arn = aws_lb_target_group.alb-tg
  target_id        = aws_instance.web-1b
  port             = 80
}
