#------VPC------
variable "vpc_cidr" {
  type = string
}
variable "vpc_name" {
  type = string
}

variable "public_subnets" {
  type = map(string)
}

variable "routetable_cidr" {
  type = string
}
