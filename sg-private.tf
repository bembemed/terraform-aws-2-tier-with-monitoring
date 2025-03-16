module "private-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "private-sg"
  description = "Security group for private instances"
  vpc_id      = module.vpc.vpc_id

  depends_on = [module.vpc]
  #ingress rules
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # egress rules
  egress_rules = ["all-all"]
}