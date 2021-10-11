# see https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.tfe_workspaces_prefix
  region  = var.google_region
}
