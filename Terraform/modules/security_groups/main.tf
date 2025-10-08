resource "aws_security_group" "alb" {
  name        = "ALB_SG"
  description = "Security group for Application Load Balancer"
  vpc_id = var.vpc_id


  ingress {
    description = "Allow HTTP ingress to ALB"
    from_port = var.alb_http_port
    to_port = var.alb_http_port
    protocol = var.protocol
    cidr_blocks = var.cidr_block
  }

  ingress {
    description = "Allow HTTPS ingress to ALB"
    from_port = var.alb_https_port
    to_port = var.alb_https_port
    protocol = var.protocol
    cidr_blocks = var.cidr_block
  }

  egress{
    description = "Allow all outbound traffic from ALB"
    from_port = var.alb_egress_port
    to_port = var.alb_egress_port
    protocol = "-1"
    cidr_blocks = var.cidr_block
  }
}

#resource "aws_security_group" "ecs" {
#  name        = "ALB_SG"
#  description = "Security group for Elastic Container Service"
#  vpc_id      = vpc_id.id

#}