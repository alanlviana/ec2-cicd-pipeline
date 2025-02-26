resource "aws_codedeploy_app" "app" {
  name = var.app_name
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "app_deployment_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = aws_iam_role.codedeploy_role.arn
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  autoscaling_groups = [aws_autoscaling_group.asg_app.name]

  deployment_style { 
    deployment_type = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.tg_app.name
    }
  }
}