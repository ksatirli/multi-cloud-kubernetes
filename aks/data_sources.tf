# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
data "azurerm_kubernetes_service_versions" "cluster" {
  location        = var.azure_region
  version_prefix  = "1.19"
  include_preview = false
}
