module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.0"

  domain_name               = trimsuffix(data.aws_route53_zone.mmsrim.name, ".")
  zone_id                   = data.aws_route53_zone.mmsrim.zone_id
  subject_alternative_names = ["*.mmsrim.com"]
  validation_method         = "DNS"
  wait_for_validation       = true


}

output "acm_certificate_arn" {
  value = module.acm.acm_certificate_arn

}