output "vpc_id" {
  value = aws_vpc.vpc_ecs.id
}

output "vpc_subnets" {
  value = [aws_subnet.subnet_ecs.id]
}

output "vpc_security_groups" {
  value = [aws_security_group.ecs_acess_http.id]
}