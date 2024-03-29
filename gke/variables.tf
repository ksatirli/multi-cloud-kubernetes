# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider
variable "google_region" {
  type        = string
  description = "The region will be used to choose the default location for regional resources."
  default     = "europe-west9" # Paris
}

variable "google_project" {
  type        = string
  description = "The project indicates the default GCP project all of your resources will be created in."
}

variable "machine_type" {
  type        = string
  description = "The machine type to be used for the GKE nodes."
  default     = "n2-standard-4"
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#role
variable "iam_roles" {
  type        = list(string)
  description = "List of IAM Roles."

  default = [
    "roles/cloudkms.admin",
    "roles/container.serviceAgent",
    "roles/iam.serviceAccountCreator",
    "roles/iam.serviceAccountDeleter",
    "roles/resourcemanager.projectIamAdmin",
  ]
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service#service
variable "project_services" {
  type        = list(string)
  description = "List of Project Services."

  default = [
    "serviceusage.googleapis.com",
    "container.googleapis.com",
    "cloudkms.googleapis.com",
  ]
}

variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}
