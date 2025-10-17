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

#------ALB------
variable "alb_name" {
  type = string
}

variable "tg_name" {
  type = string
}

variable "healthy_threshold" {
  type = number
}

variable "unhealthy_threshold" {
  type = number
}

variable "timeout" {
  type = number
}

variable "interval" {
  type = number
}

variable "tg_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "ssl_policy" {
  type = string
}

variable "https_listener_port" {
  type = number
}

#------ACM------
variable "domain_name" {
  type = string
}

variable "validation_method" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "subdomain_name" {
  type = string
}

#------Route53------
variable "sub_name" {
  type = string
}

#------ECS------
variable "cluster_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "service_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "ecr_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "ecs_desired_count" {
  type = number
}