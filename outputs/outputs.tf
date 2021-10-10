# This Output iterates over all Workspaces in `var.tfe_workspaces`
# and creates a List of Object containing all-Workspace Outputs.
# see https://www.terraform.io/docs/language/values/outputs.html
output "clusters" {
  description = "Assembled List of Objects containing per-Workspace Outputs"

  value = {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for cluster in var.tfe_workspaces :
  cluster => data.terraform_remote_state.clusters[cluster].outputs
  }
}
