## see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_id" {
  description = "EKS Cluster ID."
  value       = module.eks.cluster_arn
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_name" {
  description = "EKS Cluster Name."
  value       = var.tfe_workspaces_prefix
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "cluster_region" {
  description = "EKS Cluster Region."
  value       = var.aws_region
}

# see https://www.terraform.io/docs/language/values/outputs.html
output "console_url" {
  description = "AWS Console URL."
  value       = "https://${var.aws_region}.console.aws.amazon.com/ecs/home?region=${var.aws_region}#/clusters"
}

# this variable is used for testing purposes and has no bearing on the demo
# see https://www.terraform.io/docs/language/values/outputs.html
output "workspace_url" {
  value = "https://app.terraform.io/app/a-demo-organization/workspaces/${var.tfe_workspaces_prefix}-eks"
}
