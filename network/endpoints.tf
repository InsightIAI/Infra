data "aws_region" "current" {}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  # subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_backend_az2.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = false

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-ecr-api-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  # subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_backend_az2.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = false

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-ecr-dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "cognito_idp" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.cognito-idp"
  vpc_endpoint_type   = "Interface"
  # subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_backend_az2.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = false

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-cognito-idp-endpoint"
  }
}

resource "aws_vpc_endpoint" "bedrock" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.bedrock"
  vpc_endpoint_type   = "Interface"
  # subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_backend_az2.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = false

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-bedrock-endpoint"
  }
}

resource "aws_vpc_endpoint" "bedrock_runtime" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.bedrock-runtime"
  vpc_endpoint_type   = "Interface"
  # subnet_ids          = [aws_subnet.sn_backend.id, aws_subnet.sn_backend_az2.id, aws_subnet.sn_frontend.id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    project = var.project_name
    Name    = "${var.project_name}-bedrock-runtime-endpoint"
  }
}
