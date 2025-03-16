module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.13.0"

  name               = "it-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.alb-sg.security_group_id]

  enable_deletion_protection = false

  listeners = {
    my-http-listener = {
      port     = "80"
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    my_https_listener = {
      port            = "443"
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed response"
        status_code  = "200"
      }
      rules = {
        my-app-1 = {
          actions = [
            {
              type = "weighted-forward"
              target_groups = [
                {
                  target_group_key = "app-1"
                  weight           = 100
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          ]
          conditions = [
            {
              path_pattern = {
                values = ["/*"]
              }
            }
          ]
        }
      }


    }
  }

  target_groups = {
    "app-1" = {
      create_attachment        = false
      name_prefix              = "app-1"
      backend_protocol         = "HTTP"
      backend_port             = 8080
      target_type              = "instance"
      deregistration_delay     = 300
      load_balacing_cross_zone = false
      protocol_version         = "HTTP1"
      health_check = {
        enabled             = true
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        matcher             = "200-399"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
      }
    }


  }


}


# resource "aws_lb_target_group_attachment" "app1-attachement" {
#   for_each         = { for ec2_instance, ec2_instance_details in module.private-ec2 : ec2_instance => ec2_instance_details }
#   target_group_arn = module.alb.target_groups["app-1"].arn
#   target_id        = each.value.id
#   port             = 8080
# }

# output "test" {
#   value = { for ec2_instance, ec2_instance_details in module.private-ec2 : ec2_instance => ec2_instance_details }
# }