# this variable is used for testing purposes and has no bearing on the demo
# see https://www.terraform.io/docs/language/values/outputs.html
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/multi-cloud-k8s-aks"
}

output "console_url" {
  description = "Azure Portal URL."
  value       = "https://portal.azure.com/#home"
}
