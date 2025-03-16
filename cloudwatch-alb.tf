# Alert if HTTP 4xx errors are more than threshold value
resource "aws_cloudwatch_metric_alarm" "alb_4xx_errors" {
  alarm_name          = "alb-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "2"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "10"
  dimensions = {
    LoadBalancer = module.alb.arn_suffix
  }
  alarm_description = "This metric monitors the number of HTTP 4xx errors and triggers an alarm if the count is greater than 10"
  ok_actions        = [aws_sns_topic.myasg_sns_topic_sub.arn]
  alarm_actions     = [aws_sns_topic.myasg_sns_topic_sub.arn]

}

# Per AppELB Metrics
## - HTTPCode_ELB_5XX_Count
## - HTTPCode_ELB_502_Count
## - TargetResponseTime
# Per AppELB, per TG Metrics
## - UnHealthyHostCount
## - HealthyHostCount
## - HTTPCode_Target_4XX_Count
## - TargetResponseTime