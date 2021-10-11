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
