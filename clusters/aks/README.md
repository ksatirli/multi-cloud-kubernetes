# Workspace `aks`

> This directory contains [Microsoft Azure](https://registry.terraform.io/providers/hashicorp/azurerm/) Resources.

## Requirements

* Terraform CLI `1.0.8` or newer
* a Microsoft Azure account

## Downstream Consumption

The Kubernetes Cluster can be consumed via the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster
data "azurerm_kubernetes_cluster" "cluster" {
  name                = "multi-cloud-k8s"
  resource_group_name = "multi-cloud-k8s"
}
```

The above example uses the default values for the `name` and `resource_group_name` property. This may need to be changed for your situation.

## Notes

The implementation of this AKS Cluster is based on previous work carried out [here](https://github.com/ksatirli/dynamically-configured-infrastructure/tree/main/terraform/azure).
