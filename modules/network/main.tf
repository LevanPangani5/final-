terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.1"
    }
  }
}




# Create a new VPC only if it doesn't already exist
resource "aws_vpc" "vpc-ec1-infra" {

  cidr_block = var.vpc_cidr

  tags = {
    Name     = "${var.vpc_name}-${var.env}"
    Student  = "pangani"
    Env = var.env
  }
}

# Create subnet inside the selected VPC
resource "aws_subnet" "sbn-ec1-1a-priv-infra" {
  vpc_id            = aws_vpc.vpc-ec1-infra.id
  cidr_block        = var.sbn_1a_priv_cidr
  availability_zone = "eu-central-1a"

  tags = {
    Name     = "${var.sbn_1a_priv_name}-${var.env}"
    Student  = "pangani"
    Env = var.env
  }
}


resource "aws_subnet" "sbn-ec1-1b-priv-infra" {
  vpc_id            = aws_vpc.vpc-ec1-infra.id
  cidr_block        = var.sbn_1b_priv_cidr
  availability_zone = "eu-central-1b"

  tags = {
    Name     = "${var.sbn_1b_priv_name}-${var.env}"
    Student  = "pangani"
    Env = var.env
  }
}


resource "aws_subnet" "sbn-ec1-1a-pub-infra" {
  vpc_id            = aws_vpc.vpc-ec1-infra.id
  cidr_block        = var.sbn_1a_pub_cidr
  availability_zone = "eu-central-1a"

  tags = {
    Name     = "${var.sbn_1a_pub_name}-${var.env}"
    Student  = "pangani"
    Env = var.env
  }
}


resource "aws_subnet" "sbn-ec1-1b-pub-infra" {
  vpc_id            = aws_vpc.vpc-ec1-infra.id
  cidr_block        = var.sbn_1b_pub_cidr
  availability_zone = "eu-central-1b"

  tags = {
    Name     = "${var.sbn_1b_pub_name}-${var.env}"
    Student  = "pangani"
    Env = var.env
  }
}


# Create Network ACL
resource "aws_network_acl" "nacl-ec1-infra" {
  vpc_id = aws_vpc.vpc-ec1-infra.id

  tags = {
    Name    = "${var.nacl_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

# Associate all 4 subnets with the Network ACL
resource "aws_network_acl_association" "nacl-ec1-infra-1a-priv" {
  network_acl_id = aws_network_acl.nacl-ec1-infra.id
  subnet_id      = aws_subnet.sbn-ec1-1a-priv-infra.id
}

resource "aws_network_acl_association" "nacl-ec1-infra-1b-priv" {
  network_acl_id = aws_network_acl.nacl-ec1-infra.id
  subnet_id      = aws_subnet.sbn-ec1-1b-priv-infra.id
}

resource "aws_network_acl_association" "nacl-ec1-infra-1a-pub" {
  network_acl_id = aws_network_acl.nacl-ec1-infra.id
  subnet_id      = aws_subnet.sbn-ec1-1a-pub-infra.id
}

resource "aws_network_acl_association" "nacl-ec1-infra-1b-pub" {
  network_acl_id = aws_network_acl.nacl-ec1-infra.id
  subnet_id      = aws_subnet.sbn-ec1-1b-pub-infra.id
}

# Inbound rule: Allow all traffic from anywhere
resource "aws_network_acl_rule" "nacl-ec1-infra-inbound-rule" {
  network_acl_id = aws_network_acl.nacl-ec1-infra.id
  rule_number    = 100
  protocol       = "-1"  # All protocols
  rule_action    = "allow"
  egress         = false  # Inbound rule
  cidr_block     = "0.0.0.0/0"
}

# Outbound rule: Allow all traffic to anywhere
resource "aws_network_acl_rule" "nacl-ec1-infra-outbound-rule" {
  network_acl_id = aws_network_acl.nacl-ec1-infra.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true  # Outbound rule
  cidr_block     = "0.0.0.0/0"
}


# Create Public Route Table
resource "aws_route_table" "rt-ec1-pub-infra" {
  vpc_id = aws_vpc.vpc-ec1-infra.id

  tags = {
    Name    = "${var.rt_pub_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "pub_association_1" {
  subnet_id      = aws_subnet.sbn-ec1-1a-pub-infra.id
  route_table_id = aws_route_table.rt-ec1-pub-infra.id
}

resource "aws_route_table_association" "pub_association_2" {
  subnet_id      = aws_subnet.sbn-ec1-1b-pub-infra.id
  route_table_id = aws_route_table.rt-ec1-pub-infra.id
}

# Create Private Route Table
resource "aws_route_table" "rt-ec1-priv-infra" {
  vpc_id = aws_vpc.vpc-ec1-infra.id

  tags = {
    Name    = "${var.rt_priv_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "priv_association_1" {
  subnet_id      = aws_subnet.sbn-ec1-1a-priv-infra.id
  route_table_id = aws_route_table.rt-ec1-priv-infra.id
}

resource "aws_route_table_association" "priv_association_2" {
  subnet_id      = aws_subnet.sbn-ec1-1b-priv-infra.id
  route_table_id = aws_route_table.rt-ec1-priv-infra.id
}
