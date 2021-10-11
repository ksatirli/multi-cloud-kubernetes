variable "do_region" {
  type        = string
  description = "he slug identifier for the region where the resources will be created."
  default     = "sfo3" # San Francisco, CA
}

variable "do_token" {
  type        = string
  description = "This is the DO API token."
  sensitive   = true
}
