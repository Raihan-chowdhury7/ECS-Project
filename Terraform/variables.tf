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

variable "private_subnets" {
  type = map(string)
}

#------SGs------
variable "protocol" {
  type = string
}

variable "cidr_block" {
  type = list(string)
}

variable "alb_http_port" {
  type = number
}

variable "alb_https_port" {
  type = number
}

variable "egress_port" {
  type = number
}

variable "app_port" {
  type = number
}

