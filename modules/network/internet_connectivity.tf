#internet connectivity
 
 
# Create Internet Gateway
resource "aws_internet_gateway" "ig-ec1-infra" {
  vpc_id = aws_vpc.vpc-ec1-infra.id
 
  tags = {
    Name    = "${var.ig_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}
 
# Add route to public route table for internet access
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.rt-ec1-pub-infra.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig-ec1-infra.id
}
 
 
 
 
#NAT gateway
 
# Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip_ec1_1a_infra" {
  domain = "vpc"
 
  tags = {
    Name    = "${var.eip_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}
 
 
# Create NAT Gateway in public subnet (sbn-ec1-1a-pub-infra)
resource "aws_nat_gateway" "nat-ec1-1a-infra" {
  allocation_id = aws_eip.nat_eip_ec1_1a_infra.id
  subnet_id     = aws_subnet.sbn-ec1-1a-pub-infra.id
 
  tags = {
    Name    = "${var.nat_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
 
  depends_on = [aws_internet_gateway.ig-ec1-infra]
}
 
 
# Update private route table to route internet traffic through NAT Gateway
resource "aws_route" "private_route_nat" {
  route_table_id         = aws_route_table.rt-ec1-priv-infra.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-ec1-1a-infra.id
}
