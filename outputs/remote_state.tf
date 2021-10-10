# see https://www.terraform.io/docs/language/state/remote-state-data.html#example-usage-remote-backend-
data "terraform_remote_state" "clusters" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    for workspace in var.tfe_workspaces :
    workspace => workspace
  }

  backend = "remote"

  config = {
    organization = "a-demo-organization"

    workspaces = {
      name = "${var.tfe_workspaces_prefix}-${each.key}"
    }
  }
}

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
