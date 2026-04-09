# Aurora
resource "aws_security_group" "backend_sg" {
  name   = "${var.project_name}-backend-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-backend-sg"
  }
}

resource "aws_security_group" "aurora_sg" {
  name       = "${var.project_name}-aurora-sg"
  vpc_id     = aws_vpc.main.id

  ingress {
    from_port   = var.aurora_port
    to_port     = var.aurora_port
    protocol    = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-aurora-sg"
  }
}

resource "aws_security_group" "alb_sg" {
  name   = "${var.project_name}-alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-alb-sg"
  }
}

resource "aws_security_group" "frontend_sg" {
  name   = "${var.project_name}-frontend-sg"
  vpc_id = aws_vpc.main.id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.backend_sg.id]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-frontend-sg"
  }
}

resource "aws_security_group_rule" "backend_ingress_from_frontend" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group" "endpoint_sg" {
  name       = "${var.project_name}-endpoint-sg"
  vpc_id     = aws_vpc.main.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = [aws_subnet.sn_backend.cidr_block, aws_subnet.sn_backend_az2.cidr_block, aws_subnet.sn_frontend.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-endpoint-sg"
  }
}