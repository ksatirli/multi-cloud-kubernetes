# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "cluster" {
  account_id = "cluster-${var.tfe_workspaces_prefix}"
  project    = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "cluster_log_writer" {
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cluster.email}"
  project = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "cluster_metric_writer" {
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cluster.email}"
  project = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "cluster_monitoring_viewer" {
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.cluster.email}"
  project = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "cluster_resource_metadata_writer" {
  role    = "roles/stackdriver.resourceMetadata.writer"
  member  = "serviceAccount:${google_service_account.cluster.email}"
  project = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "cluster_metrics_writer" {
  role    = "roles/autoscaling.metricsWriter"
  member  = "serviceAccount:${google_service_account.cluster.email}"
  project = var.google_project
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "default" {
  #checkov:skip=CKV_GCP_66: Binary Authorization does not work well
  #checkov:skip=CKV_GCP_24: Pod Security Policy is not available after 1.25
  #checkov:skip=CKV_GCP_65: Google Group for GKE RBAC is not available (yet)
  provider            = google-beta
  name                = var.tfe_workspaces_prefix
  project             = var.google_project
  location            = var.google_region
  deletion_protection = false

  network                     = google_compute_network.default.id
  subnetwork                  = google_compute_subnetwork.default.id
  enable_intranode_visibility = true
  networking_mode             = "VPC_NATIVE"

  # create the smallest possible default node pool and immediately delete it
  initial_node_count       = 1
  remove_default_node_pool = true

  # use native monitoring services
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  # use stable release channel for automatic upgrades
  release_channel {
    channel = "STABLE"
  }

  # vpc-native networking (used for NEG ingress)
  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  # disable certificate auth (only allow GCP-native auth)
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # do not create external IP addresses
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "10.3.0.0/28"
  }

  workload_identity_config {
    workload_pool = "${var.google_project}.svc.id.goog"
  }

  network_policy {
    enabled = true
  }

  # enable shielded nodes (although we only have a default node for a short period of time)
  node_config {
    machine_type    = var.machine_type
    image_type      = "COS_CONTAINERD"
    service_account = google_service_account.cluster.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}

# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "default" {
  name               = var.tfe_workspaces_prefix
  project            = var.google_project
  cluster            = google_container_cluster.default.id
  initial_node_count = 1 # per zone

  node_config {
    machine_type    = var.machine_type
    image_type      = "COS_CONTAINERD"
    service_account = google_service_account.cluster.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  network_config {
    enable_private_nodes = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  lifecycle {
    ignore_changes = [
      version, # prevent conflicts when GKE is automatically patched
    ]
  }
}
