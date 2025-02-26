resource "aws_iam_role" "codedeploy_role" {
  name = "CodeDeployServiceRole-${var.app_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_policy" "codedeploy_asg_policy" {
  name        = "CodeDeployAutoScalingPolicy-${var.app_name}"
  description = "Permissions for CodeDeploy to manage Auto Scaling Groups"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "iam:PassRole",
          "ec2:CreateTags",
          "ec2:RunInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_asg_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = aws_iam_policy.codedeploy_asg_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_${var.app_name}"
  role = aws_iam_role.app_ec2_role.name
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "app_ec2_role" {
  name               = "role-${var.app_name}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "EC2CodeDeployS3Policy-${var.app_name}"
  description = "Permissions for EC2 to connect to S3"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:Get*",
          "s3:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attach" {
  role       = aws_iam_role.app_ec2_role.name
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}