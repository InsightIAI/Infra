variable "project_name" {
  type        = string
  description = "Nombre del proyecto"
}

variable "google_client_id" {
  type        = string
  description = "Google OAuth2 Client ID"
  sensitive   = true
}

variable "google_client_secret" {
  type        = string
  description = "Google OAuth2 Client Secret"
  sensitive   = true
}

variable "callback_urls" {
  type        = list(string)
  default     = ["http://localhost:3000/callback"]
}

variable "logout_urls" {
  type        = list(string)
  default     = ["http://localhost:3000/logout"]
}
