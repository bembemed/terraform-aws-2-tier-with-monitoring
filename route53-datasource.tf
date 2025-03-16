data "aws_route53_zone" "mmsrim" {
  name = "mmsrim.com"
}

output "myzone_id" {
  value = data.aws_route53_zone.mmsrim.id
}