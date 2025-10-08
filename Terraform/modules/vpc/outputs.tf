output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "public_subnet_ids" {
  description = "list of the public subnet ids"
  value = values(aws_subnet.public)[*].id
}

output "private_subnet_ids" {
  description = "list of the private subnet ids"
  value = values(aws_subnet.private)[*].id
}