# resource "aws_iam_service_linked_role" "autoscaling" {
#   aws_service_name = "autoscaling.amazonaws.com"
#   description      = "Allows Auto Scaling to call AWS services on your behalf"
#   #   custom_suffix = 
#   # Sometimes good sleep is required to have some IAM resources created before they can be used
#   provisioner "local-exec" {
#     command = "sleep 30"

#   }
# }

data "aws_iam_role" "autoscaling_service_role" {
  name = "AWSServiceRoleForAutoScaling"
}

output "services_linked_role_arn" {
  # value = aws_iam_service_linked_role.autoscaling.arn
  value = data.aws_iam_role.autoscaling_service_role.arn

}