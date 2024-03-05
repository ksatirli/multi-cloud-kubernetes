terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/google/5.19.0
    google = {
      source  = "hashicorp/google"
      version = "5.19.0"
    }
  }
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "terraform_cloud" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for role in var.iam_roles :
    role => role
  }

  project = google_service_account.terraform_cloud.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.terraform_cloud.email}"
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "project" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for service in var.project_services :
    service => service
  }

  project = google_service_account.terraform_cloud.project
  service = each.key

  disable_dependent_services = false
  disable_on_destroy         = false

  # see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service#timeouts
  timeouts {
    create = "30m"
    update = "45m"
  }
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "terraform_cloud" {
  account_id   = "terraform-cloud"
  display_name = "Terraform Cloud (${var.tfe_workspaces_prefix}-gke)"
  project      = var.google_project
}
