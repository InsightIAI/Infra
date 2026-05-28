# ─── ECR (frontend + backend) ─────────────────────────────────────────────────

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_ecr_sg.id]
  private_dns_enabled = true

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-ecr-api-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_ecr_sg.id]
  private_dns_enabled = true

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-ecr-dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.rt_private.id]

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-s3-endpoint"
  }
}

# ─── Cognito (solo frontend) ──────────────────────────────────────────────────

resource "aws_vpc_endpoint" "cognito_idp" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.cognito-idp"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_cognito_sg.id]
  private_dns_enabled = true

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-cognito-idp-endpoint"
  }
}

# ─── Bedrock (solo backend) ───────────────────────────────────────────────────

resource "aws_vpc_endpoint" "bedrock" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.bedrock"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.sn_backend.id]
  security_group_ids  = [aws_security_group.endpoint_bedrock_sg.id]
  private_dns_enabled = false

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-bedrock-endpoint"
  }
}

resource "aws_vpc_endpoint" "bedrock_runtime" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.bedrock-runtime"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.sn_backend.id]
  security_group_ids  = [aws_security_group.endpoint_bedrock_sg.id]
  private_dns_enabled = true

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-bedrock-runtime-endpoint"
  }
}
# ─── CloudWatch Logs (backend + frontend) ─────────────────────────────────────

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_cloudwatch_sg.id]
  private_dns_enabled = true

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-cloudwatch-logs-endpoint"
  }
}