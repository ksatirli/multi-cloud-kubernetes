# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "test" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    for workspace in var.tfe_workspaces :
    workspace.working_directory => workspace
  }

  auto_apply            = false
  description           = each.value.description
  execution_mode        = each.value.execution_mode
  file_triggers_enabled = true

  # This showcase uses Global Remote State to share data across Terraform Cloud Workspaces
  # see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace#global_remote_state
  global_remote_state = true

  # extract the basename of the working directory and append it to a prefix
  # see https://www.terraform.io/docs/language/functions/basename.html
  name         = "${var.tfe_workspaces_prefix}-${basename(each.value.working_directory)}"
  organization = var.tfe_organization

  tag_names = [
    basename(each.value.working_directory),
    "sharedstate"
  ]

  terraform_version = var.tfe_workspace_terraform_version
}

# TODO: add support for https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/run_trigger
