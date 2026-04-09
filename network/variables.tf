variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "aurora_port" {
  type        = number
  default     = 5432
}