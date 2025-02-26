resource "aws_launch_template" "lt_app" {
  name_prefix          = "lt-${var.app_name}-"
  image_id             = var.instance_ami
  instance_type        = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }

  user_data = filebase64("${path.module}/resources/userdata.sh")

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "asg_app" {
  name_prefix = "asg-${var.app_name}-"
  vpc_zone_identifier = var.subnets
  
  launch_template {
    id      = aws_launch_template.lt_app.id
    version = "$Latest"
  }
  
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "lb_listener_app" {
  load_balancer_arn = aws_lb.lb_app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_app.arn
  }
}

resource "aws_lb" "lb_app" {
  name               = "lb-${var.app_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets
  enable_deletion_protection = false
  tags = local.common_tags
}

resource "aws_lb_target_group" "tg_app" {
    name = "tg-${var.app_name}"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      path = "/"
      interval = 5
      timeout = 2
      healthy_threshold = 2
      unhealthy_threshold = 2
      matcher = "200-299"
    }

    tags = local.common_tags
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg_app.name
  lb_target_group_arn = aws_lb_target_group.tg_app.arn
}