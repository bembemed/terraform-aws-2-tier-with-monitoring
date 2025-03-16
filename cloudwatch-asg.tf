resource "aws_autoscaling_policy" "high_cpu" {
  name                   = "high-cpu"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
}

resource "aws_cloudwatch_metric_alarm" "app_asg_cldw" {
  alarm_name          = "app-asg-cldw"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and triggers the ASG Scaling policy to scale-out if CPU is above 80%"
  ok_actions        = [aws_sns_topic.myasg_sns_topic_sub.arn]
  alarm_actions = [
    aws_autoscaling_policy.high_cpu.arn,
    aws_sns_topic.myasg_sns_topic_sub.arn
  ]
}