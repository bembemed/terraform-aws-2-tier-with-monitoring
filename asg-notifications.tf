resource "random_pet" "this" {
  length = 2

}
#topic
resource "aws_sns_topic" "myasg_sns_topic_sub" {
  name = "myasg_sns_topic_sub"

}
#subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_sub" {
  topic_arn = aws_sns_topic.myasg_sns_topic_sub.arn
  protocol  = "email"
  endpoint  = "bembemed50@gmail.com"

}

#aws_autoscaling_notification
resource "aws_autoscaling_notification" "myasg-notifications" {
  group_names = [aws_autoscaling_group.my_asg.id]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
  ]
  topic_arn = aws_sns_topic.myasg_sns_topic_sub.arn
}