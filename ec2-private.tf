# module "private-ec2" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "5.6.0"

#   depends_on    = [module.private-sg]
#   name          = "private-ec2"
#   ami           = data.aws_ami.amzlinux.id
#   instance_type = "t2.micro"
#   # subnet_ids = [
#   #   module.vpc.private_subnets[0],
#   #   module.vpc.private_subnets[1]
#   # ]
#   vpc_security_group_ids = [module.private-sg.this_security_group_id]
#   # user_data              = file("${path.module}/app1-install.sh")
#   user_data = templatefile("app1-install.tmpl",
#     {
#       rds_db_endpoint = module.rds.db_instance_address
#     }
#   )

#   key_name = "project-key"
#   for_each = toset(["0"])

#   subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
#   tags = {
#     Name = "private-ec2"
#   }

# }