output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[0].id  
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet[0].id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.project_vpc.ipv6_cidr_block
}
