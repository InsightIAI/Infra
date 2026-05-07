# ─── VPC Link → ALB ──────────────────────────────────────────────────────────

resource "aws_security_group" "vpclink_sg" {
  name   = "${var.project_name}-vpclink-sg"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-vpclink-sg"
  }
}

# ─── ALB ─────────────────────────────────────────────────────────────────────

resource "aws_security_group" "alb_sg" {
  name   = "${var.project_name}-alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.vpclink_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.vpclink_sg.id]
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

# ─── Endpoints ───────────────────────────────────────────────────────────────
# Ingress basado en CIDRs de subnet para evitar dependencias circulares con SGs de cómputo.

resource "aws_security_group" "endpoint_cognito_sg" {
  name   = "${var.project_name}-endpoint-cognito-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.sn_frontend.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-endpoint-cognito-sg"
  }
}

resource "aws_security_group" "endpoint_bedrock_sg" {
  name   = "${var.project_name}-endpoint-bedrock-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.sn_backend.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-endpoint-bedrock-sg"
  }
}

resource "aws_security_group" "endpoint_ecr_sg" {
  name   = "${var.project_name}-endpoint-ecr-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.sn_frontend.cidr_block, aws_subnet.sn_backend.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-endpoint-ecr-sg"
  }
}

# ─── Aurora ──────────────────────────────────────────────────────────────────
# Ingress basado en CIDR de sn_backend para evitar dependencia circular con backend_sg.

resource "aws_security_group" "aurora_sg" {
  name   = "${var.project_name}-aurora-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = var.aurora_port
    to_port     = var.aurora_port
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.sn_backend.cidr_block]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-aurora-sg"
  }
}

# ─── Backend ─────────────────────────────────────────────────────────────────

resource "aws_security_group" "backend_sg" {
  name   = "${var.project_name}-backend-sg"
  vpc_id = aws_vpc.main.id

  egress {
    from_port       = var.aurora_port
    to_port         = var.aurora_port
    protocol        = "tcp"
    security_groups = [aws_security_group.aurora_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint_bedrock_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint_ecr_sg.id]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-backend-sg"
  }
}

# Ingreso desde frontend en puerto 3000 — regla separada para evitar ciclo con frontend_sg.
resource "aws_security_group_rule" "backend_ingress_from_frontend" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.frontend_sg.id
}

# ─── Frontend ─────────────────────────────────────────────────────────────────

resource "aws_security_group" "frontend_sg" {
  name   = "${var.project_name}-frontend-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint_cognito_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint_ecr_sg.id]
  }

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-frontend-sg"
  }
}
