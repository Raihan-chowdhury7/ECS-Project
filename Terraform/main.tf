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
  egress_port = var.egress_port
  app_port = var.app_port
}

module "acm" {
  source = "./modules/acm"
  domain_name = var.domain_name
  validation_method = var.validation_method
  hosted_zone_id = var.hosted_zone_id
  subdomain_name = var.subdomain_name
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  alb_sg_id = module.security_groups.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ecs_security_group_id = module.security_groups.ecs_security_group_id
  certificate_arn= module.acm.certificate_arn
  alb_name = var.alb_name
  tg_name = var.tg_name
  healthy_threshold = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  timeout = var.timeout
  interval = var.interval
  tg_port = var.tg_port
  health_check_path = var.health_check_path
  ssl_policy = var.ssl_policy
  https_listener_port = var.https_listener_port
}

module "route53" {
  source = "./modules/route53"
  alb_zone_id = module.alb.alb_zone_id
  alb_dns_name = module.alb.alb_dns_name
  hosted_zone_id = module.acm.hosted_zone_id
  sub_name = var.sub_name
}

 module "ecs" {
   source = "./modules/ecs"
   private_subnet_ids = module.vpc.private_subnet_ids
   app_sg_id = module.security_groups.alb_sg_id
   target_group_arn = module.alb.target_group_arn
   cluster_name = var.cluster_name
   aws_region = var.aws_region
   service_name = var.service_name
   container_name = var.container_name
   ecr_image = var.ecr_image
   container_port = var.container_port
   ecs_desired_count = var.ecs_desired_count
}
