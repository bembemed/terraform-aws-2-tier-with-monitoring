module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"


  name            = var.vpc-name
  cidr            = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = true
  create_database_subnet_route_table = true


  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Name = "vpc-it"
  }

  vpc_tags = {
    Name = "vpc-it"
  }
}