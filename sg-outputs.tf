output "sg-bastion-id" {
  value = module.bastion-sg.this_security_group_id
}

output "sg-bastion-vpc-id" {
  value = module.bastion-sg.this_security_group_vpc_id
}

output "sg-bastion-name" {
  value = module.bastion-sg.this_security_group_name
}

#########
output "sg-private-id" {
  value = module.private-sg.this_security_group_id
}

output "sg-private-vpc-id" {
  value = module.private-sg.this_security_group_vpc_id
}

output "sg-private-name" {
  value = module.private-sg.this_security_group_name
}