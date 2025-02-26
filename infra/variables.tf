variable "environment" {
    description = "The environment to deploy to"
    type        = string
  
}

variable "app_name" {
    description = "The name of the app"
    type        = string
}

variable "deployment_group_name" {
    description = "The name of the deployment group"
    type        = string
}

variable "asg_min_size" {
    description = "The minimum size of ASG"
    type        = number
}

variable "asg_max_size" {
    description = "The maximum size of ASG"
    type        = number
}

variable "asg_desired_capacity" {
    description = "The desired size of ASG"
    type        = number
}

variable "instance_ami" {
    description = "The AMI to use for the instance"
    type        = string
  
}

variable "subnets" {
    description = "The subnets to use for the instance"
    type        = list(string)
}

variable "vpc_id" {
    description = "The VPC ID to use for the instance"
    type        = string
  
}