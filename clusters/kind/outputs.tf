# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_config" {
  description = "Kind Cluster Config."
  value       = kind_cluster.cluster.kubeconfig
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_client_certificate" {
  description = "Kind Cluster Client Certificate."
  value       = kind_cluster.cluster.client_certificate
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_client_key" {
  description = "Kind Cluster Client Key."
  value       = kind_cluster.cluster.client_key
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_ca_certificate" {
  description = "Kind Cluster CA Certificate."
  value       = kind_cluster.cluster.cluster_ca_certificate
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_endpoint" {
  description = "Kind Cluseter Endpoint."
  value       = kind_cluster.cluster.endpoint
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://www.terraform.io/docs/language/values/outputs.html
output "workspace_url" {
  value = "https://app.terraform.io/app/kind-local-organization/workspaces/${var.tfe_workspaces_prefix}-kind"
}
