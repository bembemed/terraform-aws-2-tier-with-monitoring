resource "aws_eip" "bastion-eip" {
  depends_on = [module.bastion-ec2]
  instance   = module.bastion-ec2.id[0]
  tags = {
    Name = "bastion-eip"
  }

}