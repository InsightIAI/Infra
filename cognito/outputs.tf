output "user_pool_id" {
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  value       = aws_cognito_user_pool.main.arn
}

output "client_id" {
  value       = aws_cognito_user_pool_client.main.id
}

output "domain_name" {
  value       = aws_cognito_user_pool_domain.main.domain
}

output "cognito_domain_url" {
  value       = "https://${aws_cognito_user_pool_domain.main.domain}.auth.${data.aws_caller_identity.current.account_id}.amazoncognito.com"
}
