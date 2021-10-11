variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

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

# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_versions
data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = "1.19"
}
