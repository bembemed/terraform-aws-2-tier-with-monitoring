### Create Scheduled Action-1: Increase capacity during business hours

resource "aws_autoscaling_schedule" "increase_capacity" {
  scheduled_action_name  = "increase-capacity"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 8
  recurrence             = "0 09 * * *"
  start_time             = "2030-03-30T11:00:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
  autoscaling_group_name = aws_autoscaling_group.my_asg.id

}
### Create Scheduled Action-2: Decrease capacity during business hours
resource "aws_autoscaling_schedule" "descrease_capacity" {
  scheduled_action_name  = "decrease-capacity"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 21 * * *"
  start_time             = "2030-03-30T21:00:00Z" # Time should be provided in UTC Timezone (11pm UTC = 7PM EST)
  autoscaling_group_name = aws_autoscaling_group.my_asg.id

}