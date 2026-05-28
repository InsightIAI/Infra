variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "insight-ai"
}

variable "db_name" {
  type    = string
  default = "insightai"
}

variable "db_master_username" {
  type    = string
  default = "postgres"
}

variable "db_master_password" {
  type      = string
  sensitive = true
}
