module "bastion-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  depends_on             = [module.bastion-sg]
  name                   = "bastion-ec2"
  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = "project-key"
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion-sg.this_security_group_id]
  tags = {
    Name = "bastion-ec2"
  }
}