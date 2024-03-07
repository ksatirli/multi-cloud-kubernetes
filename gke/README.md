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

* Terraform CLI `1.7.4` or newer
* Google Cloud [account](https://console.cloud.google.com/)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| discord_application_id | Discord Application Identifier. | `string` | yes |
| discord_server_id | Discord Server Identifier. | `string` | yes |
| discord_token | Discord API Token. | `string` | yes |
| project_identifier | Human-readable Project Identifier. | `string` | yes |
| discord_administrators | List of Discord User IDs to add to the Administrator Role. | `list(string)` | no |
| discord_bots | List of Discord User IDs to add to the Bots Role. | `list(string)` | no |
| discord_colors | Hex Codes for Discord Roles. | <pre>object({<br>    administrators = string<br>    bots           = string<br>    maintainers    = string<br>    moderators     = string<br>  })</pre> | no |
| discord_maintainers | List of Discord User IDs to add to the Maintainers Role. | `list(string)` | no |
| discord_moderators | List of Discord User IDs to add to the Moderators Role. | `list(string)` | no |

### Outputs

| Name | Description |
|------|-------------|
| discord_category_channel_general | Exported Attributes for `discord_category_channel.general`. |
| discord_category_channel_info | Exported Attributes for `discord_category_channel.info`. |
| discord_category_channel_internal | Exported Attributes for `discord_category_channel.internal`. |
| discord_category_channel_labs | Exported Attributes for `discord_category_channel.labs`. |
| discord_role_administrators | Exported Attributes for `discord_role.administrators`. |
| discord_role_bots | Exported Attributes for `discord_role.bots`. |
| discord_role_everyone | Exported Attributes for `discord_role_everyone.everyone`. |
| discord_role_everyone_view_only | Exported Attributes for `discord_role.everyone_view_only`. |
| discord_role_moderators | Exported Attributes for `discord_role.moderators`. |
| discord_server | Exported Attributes for `discord_server`. |
| discord_system_channel | Exported Attributes for `discord_system_channel.main`. |
| discord_text_channel_general | Exported Attributes for `discord_text_channel.general`. |
| discord_text_channel_internal | Exported Attributes for `discord_text_channel.internal`. |
| discord_text_channel_notifications | Exported Attributes for `discord_text_channel.notifications`. |
| discord_text_channel_rules | Exported Attributes for `discord_text_channel.rules`. |
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
