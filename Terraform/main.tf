module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  public_subnets  = var.public_subnets
  routetable_cidr = var.routetable_cidr
  private_subnets = var.private_subnets

}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  protocol = var.protocol
  cidr_block = var.cidr_block
  alb_http_port = var.alb_http_port
  alb_https_port = var.alb_https_port
  alb_egress_port = var.alb_egress_port
  app_port = var.app_port
}