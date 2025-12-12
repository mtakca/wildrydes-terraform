variable "name" {
  type        = string
  description = "User pool name"
}

variable "environment" {
  type        = string
  description = "Environment identifier"
}

variable "password_min_length" {
  type        = number
  description = "Minimum password length"
  default     = 8
}

variable "access_token_validity_hours" {
  type        = number
  description = "Access token validity in hours"
  default     = 1
}

variable "id_token_validity_hours" {
  type        = number
  description = "ID token validity in hours"
  default     = 1
}

variable "refresh_token_validity_days" {
  type        = number
  description = "Refresh token validity in days"
  default     = 30
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
