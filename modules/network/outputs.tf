output "vpc_id" {
  value = aws_vpc.vpc-ec1-infra.id
}


output "sbn_1a_priv_id" {
  value = aws_subnet.sbn-ec1-1a-priv-infra.id
}

output "sbn_1b_priv_id" {
  value = aws_subnet.sbn-ec1-1b-priv-infra.id
}

output "sbn_1a_pub_id" {
  value = aws_subnet.sbn-ec1-1a-pub-infra.id
}

output "sbn_1b_pub_id" {
  value = aws_subnet.sbn-ec1-1b-pub-infra.id
}
