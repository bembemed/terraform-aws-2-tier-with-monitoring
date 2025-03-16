resource "aws_cloudwatch_log_group" "cis-log-group" {
  name = "cis-log-group-${random_pet.this.id}"
}

module "all_cis_alarms" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/cis-alarms"
  version = "2.0.0"

  disabled_controls = ["DisableOrDeleteCMK", "VPCChanges"]
  log_group_name    = aws_cloudwatch_log_group.cis-log-group.name
  alarm_actions     = [aws_sns_topic.myasg_sns_topic_sub.arn]
}