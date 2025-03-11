#SECURITY GROUPS #
 
resource "aws_security_group" "sg-infra-host" {
  name        = "${var.sg_name_website}-${var.env}"
  description = "sg for servers running our app"
  vpc_id      = aws_vpc.vpc-ec1-infra.id
 
 ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "Allow HTTP"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
 
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
 
  ingress {
    description = "Allow SSH from specific subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.168.128/28"]
  }
 
 
  ingress {
    description = "Allow all ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "${var.sg_name_website}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}
 
 
resource "aws_security_group" "sg-infra-redis" {
  name        = "${var.sg_name_redis}-${var.env}"
  description = "sg for servers running redis"
  vpc_id      = aws_vpc.vpc-ec1-infra.id
 
 
  ingress {
    description = "Allow redis port"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
     security_groups = [aws_security_group.sec-gr-infra-host.id]
  }
 
 
    ingress {
    description = "Allow SSH from specific subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.168.128/28"]
  }
 
 
  ingress {
    description = "Allow all ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "${var.sg_name_redis}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}



resource "aws_security_group" "sg-infra-alb" {
  name        = "${var.sg_name_website}-${var.env}"
  description = "sg for servers running our app"
  vpc_id      = aws_vpc.vpc-ec1-infra.id
 
 ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "${var.sg_name_website}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}