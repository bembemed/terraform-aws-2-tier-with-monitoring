
# TTS - Scaling Policy-1: Based on CPU Utilization of EC2 Instances
# This policy will scale out the instances if the average CPU Utilization is greater than 70% for 5 minutes
resource "aws_autoscaling_policy" "avg_cpu_policy_greater_than_XX" {
  name                      = "avg-cpu-policy-greater-than-70"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.my_asg.id
  estimated_instance_warmup = 300

  #CPU Utilization is above 50%

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }

}

# TTS - Scaling Policy-2: Based on ALB Target Requests
resource "aws_autoscaling_policy" "alb_target_requests_greater_than_YY" {
  name                      = "alb-target-requests-greater-than-YY"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.my_asg.id
  estimated_instance_warmup = 120
  # Number of requests > 10 completed per target in an Application Load Balancer target group.
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"

      # resource_label         = "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[0]}"
      resource_label = "${module.alb.arn_suffix}/${module.alb.target_groups["app-1"].arn_suffix}"
    }
    target_value = 10.0
  }
}