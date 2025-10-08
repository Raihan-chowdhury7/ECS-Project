resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id = aws_vpc.main.id
  availability_zone = each.key               
  cidr_block = each.value      
  map_public_ip_on_launch = true

  tags = merge(var.tags, { 
    Name = "${var.vpc_name}-public-${each.key}" 
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { 
    Name = "${var.vpc_name}-Internet_gateway" 
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.routetable_cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.tags, { 
    Name = "${var.vpc_name}-Route_Table-public" 
  })
}

resource "aws_route_table_association" "public_subnets" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key               
  
  tags = merge(var.tags, { 
    Name = "${var.vpc_name}-private-${each.key}" 
  })
}

resource "aws_eip" "nat" {
  domain   = "vpc"
}

locals {
  nat_az = sort(keys(aws_subnet.public))[0]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[local.nat_az].id

  tags = merge(var.tags, { 
    Name = "${var.vpc_name}-NAT-GW" 
    })
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.routetable_cidr
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(var.tags, { 
    Name = "${var.vpc_name}-Route_Table-private" 
  })
}

resource "aws_route_table_association" "private_subnets" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
