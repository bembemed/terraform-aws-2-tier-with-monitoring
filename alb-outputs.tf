output "id" {
  value = module.alb.id
}

output "arn" {
  value = module.alb.arn

}

output "arn-suffix" {
  value = module.alb.arn_suffix

}

output "dns" {
  value = module.alb.dns_name
}

output "zoneID" {
  value = module.alb.zone_id
}

####
#listeners

output "listener" {
  value = module.alb.listeners
}

output "listeners_rules" {
  value = module.alb.listener_rules

}

output "target_group" {
  value = module.alb.target_groups
}