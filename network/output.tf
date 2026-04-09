output "aurora_sg_id" {
  value = aws_security_group.aurora_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "backend_subnet_id" {
  value = aws_subnet.sn_backend.id
}

output "backend_subnet_az2_id" {
  value = aws_subnet.sn_backend_az2.id
}

output "backend_subnet_ids" {
  value = [aws_subnet.sn_backend.id, aws_subnet.sn_backend_az2.id]
}

output "frontend_subnet_id" {
  value = aws_subnet.sn_frontend.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_sg.id
}

output "frontend_sg_id" {
  value = aws_security_group.frontend_sg.id
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "bedrock_endpoint_id" {
  value = aws_vpc_endpoint.bedrock.id
}

output "bedrock_runtime_endpoint_id" {
  value = aws_vpc_endpoint.bedrock_runtime.id
}
