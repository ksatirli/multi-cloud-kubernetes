variable "tfe_organization" {
  type        = string
  description = "Name of the organization."
  default     = "a-demo-organization"
}

variable "tfe_token" {
  type        = string
  description = "The token used to authenticate with Terraform Cloud/Enterprise."
  sensitive   = true
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
# and https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
variable "tfe_workspaces" {
  type = list(object({
    description       = string
    execution_mode    = string
    working_directory = string
  }))

  description = "Complex Object of Terraform Cloud Workspaces."

  default = [{
    description       = "Manages AKS Clusters."
    execution_mode    = "local"
    working_directory = "/clusters/aks"
    }, {
    description       = "Manages DOKS Clusters."
    execution_mode    = "local"
    working_directory = "/clusters/do"
    }, {
    description       = "Manages EKS Clusters."
    execution_mode    = "local"
    working_directory = "/clusters/eks"
    }, {
    description       = "Manages GKE Clusters."
    execution_mode    = "local"
    working_directory = "/clusters/gke"
    }, {
    description       = "Collects Terraform Cloud Workspace Outputs."
    execution_mode    = "remote"
    working_directory = "/outputs"
  }]

  validation {
    condition     = length(var.tfe_workspaces) > 0
    error_message = "The `tfe_workspaces` list must contain at least one workspace."
  }
}

variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

variable "tfe_workspace_terraform_version" {
  type        = string
  description = "The version of Terraform to use for this workspace."
  default     = "1.0.8"
}
