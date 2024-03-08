# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_id" {
  description = "DOKS Cluster ID."
  value       = digitalocean_kubernetes_cluster.cluster.id
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_name" {
  description = "DOKS Cluster Name."
  value       = digitalocean_kubernetes_cluster.cluster.name
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_region" {
  description = "DOKS Cluster Region."
  value       = digitalocean_kubernetes_cluster.cluster.region
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "console_url" {
  description = "DigitalOcean Console URL."
  value       = "https://cloud.digitalocean.com/kubernetes/clusters/${digitalocean_kubernetes_cluster.cluster.id}"
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "command_add_to_kubeconfig" {
  description = "Command to add Cluster to .kubeconfig."
  value       = "doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.cluster.id}"
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://developer.hashicorp.com/terraform/language/values/outputs
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/${var.tfe_workspaces_prefix}-doks"
}
