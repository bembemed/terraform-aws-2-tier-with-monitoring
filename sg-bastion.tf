module "bastion-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  depends_on  = [module.vpc]
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = module.vpc.vpc_id

  #ingress rules
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # egress rules
  egress_rules = ["all-all"]
}