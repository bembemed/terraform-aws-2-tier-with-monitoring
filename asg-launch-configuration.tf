# module "asg-app1-launch-configuration" {
#   source  = "terraform-aws-modules/autoscaling/aws/"
#   version = "4.1.0"

#   name            = "asg-app1"
#   use_name_prefix = false



#   #Asg Lifecycle hooks
#   initial_lifecycle_hook = [
#     {
#       name                  = "app1-lifecycle-hook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 60
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
#       notification_metadata = jsonencode({ "hello" = "world" })

#     },
#     {
#       name                  = "app1-lifecycle-hook-terminate"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 180
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
#       notification_metadata = jsonencode({ "goodbye" = "world" })
#     }

#   ]

#   #ASG Instance refresh
#   instance_refresh = {
#     strategy = "Rolling"
#     preferences = {
#       min_healthy_percentage = 50
#     }
#     triggers = ["tag", "desired_capacity" /*,"launch configuration" */] # Desired Capacity here added for demostrating the Instance Refresh scenario
#   }

#   #ASG luanch configuration
#   lc_name_prefix = "app1"
#   use_lc         = true
#   create_lc      = true


#   # Add Spot Instances, which creates Spot Requests to get instances at the price listed (Optional argument)
#   #spot_price        = "0.014"
#   spot_price = "0.015" # Change for Instance Refresh test





#   metadata_options = {
#     http_tokens                 = "optional"
#     http_put_response_hop_limit = 32
#     http_endpoint               = "enabled"
#   }

# }

resource "aws_launch_template" "my_lauch_template" {
  name = "my-launch-template"

  # image_id          = data.aws_ami.amazon-linux.id
  image_id      = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  key_name      = "project-key"
  # user_data         = filebase64("${path.module}/app1-install.tmpl")
  user_data              = base64encode(templatefile("${path.module}/app1-install.tmpl", { rds_db_endpoint = module.rds.db_instance_address }))
  ebs_optimized          = true
  update_default_version = true
  vpc_security_group_ids = [module.private-sg.this_security_group_id]
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 8
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }
  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app1"
    }
  }

}

resource "aws_autoscaling_group" "my_asg" {
  name_prefix         = "my-asg-"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = module.vpc.private_subnets
  # service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn
  service_linked_role_arn = data.aws_iam_role.autoscaling_service_role.arn

  # Associate with Alb with Ask
  # target_group_arns = module.alb.target_group_arns
  target_group_arns = [module.alb.target_groups["app-1"].arn]
  launch_template {
    id      = aws_launch_template.my_lauch_template.id
    version = aws_launch_template.my_lauch_template.latest_version

  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag", "desired_capacity" /*,"launch configuration" */] # Desired Capacity here added for demostrating the Instance Refresh scenario
  }

}