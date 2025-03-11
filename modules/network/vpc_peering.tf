### VPC PEERING RUNNRS _ INFRA
 
 
# Create VPC Peering Connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = var.runner_vpc_id  # ID of the GitLab Runners VPC
  peer_vpc_id =    aws_vpc.vpc-ec1-infra.id   # ID of the infrastructure VPC
  auto_accept = false
 
  tags = {
    Name    = "${var.vpc_peer_name}-${var.env}"
    Student = "pangani"
    Env = var.env
  }
}
 
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true
}
 
 
 
# Update Route Table in Runner VPC to Route Traffic to Infra VPC
resource "aws_route" "runners-to-infra" {
  route_table_id         = var.runner_rt_id   # route table ID of the Runner VPC
  destination_cidr_block = aws_vpc.vpc-ec1-infra.cidr_block  # CIDR of Infra VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
 
 
 
# Update Route Table in Infra VPC to Route Traffic to Runner VPC
resource "aws_route" "infra-pub-to-runner" {
  route_table_id         = aws_route_table.rt-ec1-pub-infra.id   # route table ID of the Infra VPC
  destination_cidr_block = var.runner_cidr  # CIDR of Runner VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
 
 
# Update Route Table in Infra VPC to Route Traffic to Runner VPC
resource "aws_route" "infra-priv-to-runner" {
  route_table_id         = aws_route_table.rt-ec1-priv-infra.id   # route table ID of the Infra VPC
  destination_cidr_block = var.runner_cidr  # CIDR of Runner VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
 
