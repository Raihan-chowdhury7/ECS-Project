module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  public_subnets = var.public_subnets
  routetable_cidr = var.routetable_cidr

}
