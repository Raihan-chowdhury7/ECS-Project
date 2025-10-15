#variable "vpc_id" {
#  description = "ID of the VPC to attach security groups"
#  type = string
#}

#variable "private_subnet_ids" {
#  description = "List of private subnet IDs"
#  type        = list(string)
#}

variable "cluster_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "service_name" {
  type = string
}