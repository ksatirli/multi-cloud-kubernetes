# see https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs
provider "google-beta" {
  project = var.google_project
}
