# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_id" {
  description = "AKS Cluster ID."
  value       = module.aks.aks_id
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_name" {
  description = "AKS Cluster Name."
  value       = module.aks.aks_name
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_region" {
  description = "AKS Cluster Region."
  value       = module.aks.location
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "cluster_resource_group" {
  description = "AKS Cluster Resource Group."
  value       = azurerm_resource_group.cluster.name
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "console_url" {
  description = "Azure Portal URL."
  value       = "https://portal.azure.com/#home"
}

# see https://developer.hashicorp.com/terraform/language/values/outputs
output "command_add_to_kubeconfig" {
  description = "Command to add Cluster to .kubeconfig."

  # see https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials
  value = "az aks get-credentials --name ${module.aks.aks_name} --resource-group ${azurerm_resource_group.cluster.name} --admin"
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://developer.hashicorp.com/terraform/language/values/outputs
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/${var.tfe_workspaces_prefix}-aks"
}
