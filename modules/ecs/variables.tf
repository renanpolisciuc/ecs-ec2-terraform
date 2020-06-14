variable "vpc" {
  type = map
  default = {
    subnets         = []
    security_groups = []
  }
}

variable "launch_configuration" {
  type = map
  default = {
    name          = "my-launch-configuration"
    instance_type = "t2.micro"
    ec2_profile   = null
  }
}

variable "autoscaling_group" {
  type = map
  default = {
    name             = "my-escaling-group-name"
    min_size         = 1
    max_size         = 3
    desired_capacity = 1
  }
}