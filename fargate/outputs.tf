output "ecs_cluster_id" {
  value       = aws_ecs_cluster.main.id
  description = "ECS cluster ID used by the backend deployment"
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "IAM role ARN used by ECS task execution"
}

output "alb_arn" {
  value       = aws_lb.main.arn
  description = "Application Load Balancer ARN"
}

output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "Application Load Balancer DNS name"
}

output "alb_zone_id" {
  value = aws_lb.main.zone_id
}