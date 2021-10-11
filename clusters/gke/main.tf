# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "terraform_cloud" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
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
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
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

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "cluster" {
  enable_intranode_visibility = true
  enable_shielded_nodes       = true
  enable_tpu                  = false
  initial_node_count          = 3
  location                    = var.google_region

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS",
    ]
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
    ]
  }

  name = var.tfe_workspaces_prefix

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-standard-4"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]

    preemptible     = false
    service_account = google_service_account.cluster.email

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }

  }

  release_channel {
    channel = "REGULAR"
  }

  timeouts {
    create = "30m"
    update = "45m"
  }
}
