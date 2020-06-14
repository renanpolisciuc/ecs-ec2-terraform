resource "aws_ecs_cluster" "ecs_cluster" {
  name = "cluster-ecs"
}


resource "aws_ecs_service" "nginx_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.autoscaling_group.desired_capacity
  launch_type     = "EC2"
}

data "template_file" "nginx_user_data" {
  template = "${file("${path.module}/user-data/launch_configuration.tpl")}"
  vars = {
    cluster_name = aws_ecs_cluster.ecs_cluster.name
  }
}

resource "aws_launch_configuration" "ecs" {
  image_id             = data.aws_ami.ecs_ami.image_id
  user_data            = data.template_file.nginx_user_data.rendered
  name                 = var.launch_configuration.name
  instance_type        = var.launch_configuration.instance_type
  iam_instance_profile = var.launch_configuration.ec2_profile
  security_groups      = var.vpc.security_groups
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  name                 = var.autoscaling_group.name
  min_size             = var.autoscaling_group.min_size
  max_size             = var.autoscaling_group.max_size
  desired_capacity     = var.autoscaling_group.desired_capacity
  vpc_zone_identifier  = var.vpc.subnets
  launch_configuration = aws_launch_configuration.ecs.name
}

data "aws_ami" "ecs_ami" {
  owners      = ["amazon"]
  name_regex  = "^amzn-ami-*"
  most_recent = true
}
