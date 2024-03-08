# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "cluster" {
  name     = var.tfe_workspaces_prefix
  location = var.azure_region
}

# see https://registry.terraform.io/modules/Azure/aks/azurerm/8.0.0
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "8.0.0"

  prefix              = var.tfe_workspaces_prefix
  resource_group_name = azurerm_resource_group.cluster.name
  kubernetes_version  = data.azurerm_kubernetes_service_versions.cluster.latest_version

  admin_username       = null
  azure_policy_enabled = true

  # for production environments, enable logging
  log_analytics_workspace_enabled = false
  net_profile_pod_cidr            = "10.1.0.0/16"

  # for production environments, use a private cluster
  private_cluster_enabled = false

  # enable a public FQDN for `kubectl` access
  private_cluster_public_fqdn_enabled = true

  rbac_aad                          = true
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true

  # see https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on
  depends_on = [
    module.network
  ]
}
