# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "cluster" {
  enable_intranode_visibility = true
  enable_shielded_nodes       = true
  enable_tpu                  = false
  initial_node_count          = 3
  location                    = var.google_region
  name                        = var.tfe_workspaces_prefix

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

  project = var.google_project

  release_channel {
    channel = "REGULAR"
  }

  timeouts {
    create = "30m"
    update = "45m"
  }
}
