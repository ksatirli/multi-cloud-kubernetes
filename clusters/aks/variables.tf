variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

variable "azure_region" {
  type        = string
  description = "The Azure Region where the Resources should exist."
  default     = "eastus"
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
data "azurerm_kubernetes_service_versions" "cluster" {
  location        = var.azure_region
  version_prefix  = "1.19"
  include_preview = false
}
