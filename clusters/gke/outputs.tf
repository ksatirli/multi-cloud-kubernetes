output "console_url" {
  description = "Google Cloud Console URL."
  value       = "https://console.cloud.google.com/home/activity?project=${var.tfe_workspaces_prefix}"
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_id" {
  description = "GKE Cluster ID."
  value       = google_container_cluster.default.id
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_name" {
  description = "GKE Cluster Name."
  value       = google_container_cluster.default.name
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_region" {
  description = "GKE Cluster Region."
  value       = google_container_cluster.default.location
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://www.terraform.io/docs/language/values/outputs.html
output "workspace_url" {
  description = "Terraform Cloud Workspace URL."
  value       = "https://app.terraform.io/app/a-demo-organization/workspaces/${var.tfe_workspaces_prefix}-gke"
}
