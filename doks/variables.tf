variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

variable "do_region" {
  type        = string
  description = "The slug identifier for the region where the resources will be created."
  default     = "ams3" # Amsterdam, NL
}

variable "do_token" {
  type        = string
  description = "This is the DO API token."
  sensitive   = true
}
