resource "aws_route53_record" "app1" {
  zone_id = data.aws_route53_zone.mmsrim.zone_id
  name    = "bembe.mmsrim.com"
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true

  }
}