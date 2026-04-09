resource "aws_ecr_repository" "backend" {
  name = "back-end"

  tags = {
    "project" = var.project_name,
    Name      = "${var.project_name}-backend-repository"
  }
}

resource "aws_ecr_repository" "frontend" {
  name = "front-end"

  tags = {
    "project" = var.project_name,
    Name      = "${var.project_name}-frontend-repository"
  }
}
