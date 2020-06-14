resource "aws_ecs_task_definition" "nginx" {
  family                = "nginx"
  container_definitions = file("${path.module}/task-definitions/nginx.json")

  requires_compatibilities = ["EC2"]
}
