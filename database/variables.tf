variable "project_name" {
  type        = string
}

variable "db_name" {
  type        = string
  default     = "insightai"
}

variable "db_master_username" {
  type        = string
  default     = "postgres"
}

variable "db_master_password" {
  type        = string
  sensitive   = true
}


variable "port" {
  type        = number
  default     = 5432
}

variable "sg_ids" {
  type = list(string)
}

variable "db_subnet_ids" {
  type = list(string)
}