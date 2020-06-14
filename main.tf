module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source = "./modules/ecs"
  vpc = {
    subnets         = module.vpc.vpc_subnets
    security_groups = module.vpc.vpc_security_groups
  }
  launch_configuration = {
    name          = "my-launch_configuration"
    instance_type = "t2.micro"
    ec2_profile   = module.iam.ec2_iam_profile
  }

  autoscaling_group = {
    name             = "my-autoscaling_group-name"
    min_size         = 1
    max_size         = 3
    desired_capacity = 1
  }
}