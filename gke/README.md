# Workspace `gke`

> This directory contains [Google Cloud](https://registry.terraform.io/providers/hashicorp/google/) resources for a Kubernetes deployment.

## Table of Contents

<!-- TOC -->
* [Workspace `gke`](#workspace-gke)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
    * [Downstream Consumption](#downstream-consumption)
  * [Notes](#notes)
<!-- TOC -->

## Requirements

* Terraform `1.7.4` or [newer](https://developer.hashicorp.com/terraform/downloads).
* Terraform Cloud [Account](https://app.terraform.io/session)
* Google Cloud [account](https://console.cloud.google.com/)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| google_project | The project indicates the default GCP project all of your resources will be created in. | `string` | yes |
| google_region | The region will be used to choose the default location for regional resources. | `string` | no |
| iam_roles | List of IAM Roles. | `list(string)` | no |
| machine_type | The machine type to be used for the GKE nodes. | `string` | no |
| project_services | List of Project Services. | `list(string)` | no |
| tfe_workspaces_prefix | Prefix for TFE Workspaces. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster_id | GKE Cluster ID. |
| cluster_name | GKE Cluster Name. |
| cluster_region | GKE Cluster Region. |
| console_url | Google Cloud Console URL. |
| workspace_url | Terraform Cloud Workspace URL. |
<!-- END_TF_DOCS -->

### Downstream Consumption

The Kubernetes Cluster can be consumed via the [google_container_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster
data "google_container_cluster" "cluster" {
  name     = "multi-cloud-k8s"
  location = "us-west2"
}
```

## Notes

The implementation of this GKE Cluster is based on previous work carried out by [Bruno Schaatsbergen](https://github.com/bschaatsbergen/proxying-your-way-into-gke). If you're looking to setup a private GKE Cluster, we recommend checking out this repository to understand how to access it, and manage the resources inside using Terraform.
