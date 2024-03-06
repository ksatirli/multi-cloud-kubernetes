locals {
  services = [
    "serviceusage.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com",
    "networking.googleapis.com",
    "cloudkms.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "default" {
  for_each                   = toset(local.services)
  service                    = each.value
  disable_on_destroy         = false
  project                    = var.google_project
}
