variable "jwt_profile" {
  type        = string
  description = "Zitadel Machine User JSON string"
  sensitive   = true
}

variable "smtp_host" {
  type      = string
  sensitive = true
}

variable "smtp_user" {
  type      = string
  sensitive = true
}

variable "smtp_password" {
  type      = string
  sensitive = true
}
