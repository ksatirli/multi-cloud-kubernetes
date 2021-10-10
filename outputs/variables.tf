variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

variable "tfe_workspaces" {
  type = list(string)

  description = "List of Terraform Cloud Workspaces."

  default = [
    "aks",
    "do",
    "eks",
    "gke"
  ]
}
