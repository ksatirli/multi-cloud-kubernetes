# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "cluster" {
  name     = var.tfe_workspaces_prefix
  location = var.azure_region
}

