# Workspace `EKS`

> This directory contains [AWS](https://registry.terraform.io/providers/hashicorp/aws/) resources for a Kubernetes deployment.

## Table of Contents

<!-- TOC -->
* [Workspace `EKS`](#workspace-eks)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
    * [Downstream Consumption](#downstream-consumption)
<!-- TOC -->

## Requirements

* Terraform `1.7.4` or [newer](https://developer.hashicorp.com/terraform/downloads).
* Terraform Cloud [Account](https://app.terraform.io/session)
* AWS [account](https://aws.amazon.com/account/)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| aws_region | This is the AWS region. | `string` | no |
| subnet_az | List of strings of Availability Zone suffixes. | `list(string)` | no |
| tfe_workspaces_prefix | Prefix for TFE Workspaces. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster_id | EKS Cluster ID. |
| cluster_name | EKS Cluster Name. |
| cluster_region | EKS Cluster Region. |
| console_url | AWS Console URL. |
| workspace_url | this variable is used for testing purposes and has no bearing on the demo see https://developer.hashicorp.com/terraform/language/values/outputs |
<!-- END_TF_DOCS -->

### Downstream Consumption

The Kubernetes Cluster can be consumed via the [aws_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster
data "aws_eks_cluster" "cluster" {
  name = "multi-cloud-k8s"
}
```

The above example uses the default values for the `name` property. This may need to be changed for your situation.
