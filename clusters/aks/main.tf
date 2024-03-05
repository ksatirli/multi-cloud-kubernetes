# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "cluster" {
  name     = var.tfe_workspaces_prefix
  location = var.azure_region
}

# see https://registry.terraform.io/modules/Azure/aks/azurerm/4.13.0
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "4.13.0"

  resource_group_name             = azurerm_resource_group.cluster.name
  agents_count                    = 3
  enable_http_application_routing = true
  kubernetes_version              = data.azurerm_kubernetes_service_versions.cluster.latest_version
  orchestrator_version            = data.azurerm_kubernetes_service_versions.cluster.latest_version
  os_disk_size_gb                 = 100
  prefix                          = var.tfe_workspaces_prefix
  vnet_subnet_id                  = module.network.vnet_subnets[0]

  # see https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on
  depends_on = [
    module.network
  ]
}
