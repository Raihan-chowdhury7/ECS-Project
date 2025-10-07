resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  for_each                = var.public_subnets          # 1 per map entry
  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.key                     # "eu-west-2a"
  cidr_block              = each.value                   # "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "${var.vpc_name}-public-${each.key}" })
}
