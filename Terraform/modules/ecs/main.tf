resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${var.service_name}"
  retention_in_days = 7
}

data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "task_exec_role" {
  name               = "${var.service_name}-task-exec-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
}


resource "aws_ecs_task_definition" "service" {
  family = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  execution_role_arn = "" #will add value once completed iam stuff

  container_definitions = jsonencode([
    {
      name      = "" #how do i get this?
      image     = "" #how do i get this?
      essential = true
      portMappings = [
        {
          containerPort = 3000
        }
      ]
      logConfiguration = {
      logDriver = "awslogs" 
      options = {
        awslogs-group = aws_cloudwatch_log_group.this.name
        awslogs-region = var.aws_region
      }
      }
    }
  ])
}