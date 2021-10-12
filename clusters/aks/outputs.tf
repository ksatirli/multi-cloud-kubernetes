# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_id" {
  description = "AKS Cluster ID."
  value       = module.aks.aks_id
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_name" {
  description = "AKS Cluster Name."
  value       = var.tfe_workspaces_prefix
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_region" {
  description = "AKS Cluster Region."
  value       = module.aks.location
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_resource_group" {
  description = "AKS Cluster Resource Group."
  value       = azurerm_resource_group.cluster.name
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "console_url" {
  description = "Azure Portal URL."
  value       = "https://portal.azure.com/#home"
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://www.terraform.io/docs/language/values/outputs.html
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/${var.tfe_workspaces_prefix}-aks"
}
