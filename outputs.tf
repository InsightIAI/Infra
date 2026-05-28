output "network_vpc_id" {
  value = module.network.vpc_id
}

output "network_backend_subnet_id" {
  value = module.network.backend_subnet_id
}

output "network_backend_subnet_ids" {
  value = module.network.backend_subnet_ids
}

output "network_frontend_subnet_id" {
  value = module.network.frontend_subnet_id
}

output "network_backend_sg_id" {
  value = module.network.backend_sg_id
}

output "network_vpclink_sg_id" {
  value = module.network.vpclink_sg_id
}

output "backend_alb_arn" {
  value = module.fargate.alb_arn
}

output "backend_alb_dns_name" {
  value = module.fargate.alb_dns_name
}

output "aurora_cluster_endpoint" {
  value = module.database.aurora_cluster_endpoint
}

output "ecs_cluster_id" {
  value = module.fargate.ecs_cluster_id
}

output "ecs_task_execution_role_arn" {
  value = module.fargate.ecs_task_execution_role_arn
}

output "backend_repository_url" {
  value = module.erc.backend_docker_repository_url
}

output "frontend_repository_url" {
  value = module.erc.frontend_docker_repository_url
}
