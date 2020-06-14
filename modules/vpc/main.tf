resource "aws_vpc" "vpc_ecs" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    application = "ecs"
  }
}


resource "aws_subnet" "subnet_ecs" {
  vpc_id                  = aws_vpc.vpc_ecs.id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true
}


resource "aws_route_table_association" "ecs_route_association" {
  subnet_id      = aws_subnet.subnet_ecs.id
  route_table_id = aws_vpc.vpc_ecs.main_route_table_id
}


resource "aws_internet_gateway" "ecs_internet_gateway" {
  vpc_id = aws_vpc.vpc_ecs.id
}

resource "aws_route" "route_to_internet" {
  route_table_id         = aws_vpc.vpc_ecs.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ecs_internet_gateway.id
}


resource "aws_security_group" "ecs_acess_http" {
  name   = "ecs_access_http"
  vpc_id = aws_vpc.vpc_ecs.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

