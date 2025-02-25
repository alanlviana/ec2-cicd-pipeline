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