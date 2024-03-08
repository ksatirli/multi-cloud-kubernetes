# Workspace `aks`

> This directory contains [Microsoft Azure](https://registry.terraform.io/providers/hashicorp/azurerm/) resources for a Kubernetes deployment.

## Table of Contents

<!-- TOC -->
* [Workspace `aks`](#workspace-aks)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
    * [Downstream Consumption](#downstream-consumption)
<!-- TOC -->

## Requirements

* Terraform CLI `1.7.4` or newer
* Microsoft Azure [account](https://azure.microsoft.com/free)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| azure_region | The Azure Region where the Resources should exist. | `string` | no |
| tfe_workspaces_prefix | Prefix for TFE Workspaces. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster_id | AKS Cluster ID. |
| cluster_name | AKS Cluster Name. |
| cluster_region | AKS Cluster Region. |
| cluster_resource_group | AKS Cluster Resource Group. |
| command_add_to_kubeconfig | Command to add Cluster to .kubeconfig. |
| console_url | Azure Portal URL. |
| workspace_url | this variable is used for testing purposes and has no bearing on the demo see https://developer.hashicorp.com/terraform/language/values/outputs |
<!-- END_TF_DOCS -->

### Downstream Consumption

#### In Terraform

The Kubernetes Cluster can be consumed via the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster
data "azurerm_kubernetes_cluster" "cluster" {
  name                = "multi-cloud-k8s-aks"
  resource_group_name = "multi-cloud-k8s"
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.cluster_ca_certificate)
}
```
The above example uses the default values for the `name` and `resource_group_name` property. This may need to be changed for your situation.

#### In `kubectl`

To add the cluster configuration to your `kubectl` configuration, use the following Terraform Output:

```sh
terraform output -raw command_add_to_kubeconfig
```

