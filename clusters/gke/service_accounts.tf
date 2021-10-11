# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "terraform_cloud" {
  account_id   = "terraform-cloud"
  display_name = "Terraform Cloud (${var.tfe_workspaces_prefix}-gke)"
  project      = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "cluster" {
  account_id   = "cluster"
  display_name = "Cluster Service Account (${var.tfe_workspaces_prefix}-gke)"
  project      = var.google_project
}
