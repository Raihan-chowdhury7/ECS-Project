variable "alb_sg_id" {
  type = string
}

variable "ecs_security_group_id" {
  type = string
}

variable "vpc_id" {
  description = "ID of the VPC to attach security groups"
  type = string
}

variable "alb_name" {
  type = string
}

variable "tg_name" {
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
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

variable "certificate_arn" {
  type = string
}

variable "https_listener_port" {
  type = number
}