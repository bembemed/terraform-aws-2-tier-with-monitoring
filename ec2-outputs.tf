output "ec2-bastion-id" {
  value = module.bastion-ec2.id
}

output "ec2-bastion-list-ip" {
  value = module.bastion-ec2.public_ip
}

# output "ec2-private-id" {
#   value = module.private-ec2.id

# }

# output "ec2-private-list-ip" {
#   value = module.private-ec2.private_ip

# }