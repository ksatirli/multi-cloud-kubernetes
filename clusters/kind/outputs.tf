# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_config" {
  description = "Kind Cluster Config."
  value       = kind_cluster.cluster.kubeconfig
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_client_certificate" {
  description = "Kind Cluster Client Certificate."
  value       = kind_cluster.cluster.client_certificate
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_client_key" {
  description = "Kind Cluster Client Key."
  value       = kind_cluster.cluster.client_key
  sensitive   = true
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_ca_certificate" {
  description = "Kind Cluster CA Certificate."
  value       = kind_cluster.cluster.cluster_ca_certificate
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_endpoint" {
  description = "Kind Cluseter Endpoint."
  value       = kind_cluster.cluster.endpoint
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://developer.hashicorp.com/terraform/language/values/outputs
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/${var.tfe_workspaces_prefix}-kind"
}
