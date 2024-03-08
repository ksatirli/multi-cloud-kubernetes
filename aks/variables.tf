variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

variable "azure_region" {
  type        = string
  description = "The Azure Region where the Resources should exist."
  default     = "francecentral"
}
