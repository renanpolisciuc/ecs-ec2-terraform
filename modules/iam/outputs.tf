output "ec2_iam_profile" {
  value = aws_iam_instance_profile.ecs_ec2_profile.name
}