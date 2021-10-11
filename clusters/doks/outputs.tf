# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_id" {
  description = "DOKS Cluster ID."
  value       = digitalocean_kubernetes_cluster.cluster.id
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_name" {
  description = "DOKS Cluster Name."
  value       = digitalocean_kubernetes_cluster.cluster.name
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_region" {
  description = "DOKS Cluster Region."
  value       = digitalocean_kubernetes_cluster.cluster.region
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "console_url" {
  description = "DigitalOcean Console URL."
  value       = "https://cloud.digitalocean.com/kubernetes/clusters"
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://www.terraform.io/docs/language/values/outputs.html
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/multi-cloud-k8s-doks"
}
