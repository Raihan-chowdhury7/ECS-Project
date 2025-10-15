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

variable "vpc_id" {
  description = "ID of the VPC to attach security groups"
  type = string
}

