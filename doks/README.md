# Workspace `doks`

> This directory contains [DigitalOcean](https://registry.terraform.io/providers/digitalocean/digitalocean) resources for a Kubernetes deployment.

## Table of Contents

<!-- TOC -->
* [Workspace `doks`](#workspace-doks)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
    * [Downstream Consumption](#downstream-consumption)
      * [In Terraform](#in-terraform)
      * [In `kubectl`](#in-kubectl)
<!-- TOC -->

## Requirements

* Terraform CLI `1.7.4` or newer
* a DigitalOcean [account](https://m.do.co/c/b73b4af31c09)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| do_token | This is the DO API token. | `string` | yes |
| do_region | The slug identifier for the region where the resources will be created. | `string` | no |
| tfe_workspaces_prefix | Prefix for TFE Workspaces. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster_id | DOKS Cluster ID. |
| cluster_name | DOKS Cluster Name. |
| cluster_region | DOKS Cluster Region. |
| command_add_to_kubeconfig | Command to add Cluster to .kubeconfig. |
| console_url | DigitalOcean Console URL. |
| workspace_url | this variable is used for testing purposes and has no bearing on the demo see https://developer.hashicorp.com/terraform/language/values/outputs |
<!-- END_TF_DOCS -->

### Downstream Consumption

#### In Terraform

The Kubernetes Cluster can be consumed via the [digitalocean_kubernetes_cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster
data "digitalocean_kubernetes_cluster" "cluster" {
  name = "multi-cloud-k8s"
}
```

The above example uses the default values for the `name` property. This may need to be changed for your situation.

#### In `kubectl`

To add the cluster configuration to your `kubectl` configuration, use the following Terraform Output:

```sh
terraform output -raw command_add_to_kubeconfig
```
