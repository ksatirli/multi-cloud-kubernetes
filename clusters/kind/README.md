# Workspace `kind`

> This directory contains [kind Provider](https://registry.terraform.io/providers/kyma-incubator/kind/latest) Resources.

## Requirements

* Terraform CLI `1.0.9` or newer
* ```

## Downstream Consumption

The Kubernetes Cluster can be consumed via the [attributes reference](https://registry.terraform.io/providers/kyma-incubator/kind/latest/docs/resources/cluster#attributes-reference):

```hcl
output "cluster_config" {
  description = "Kind Cluster Config."
  value       = kind_cluster.cluster.kubeconfig
}
```

## Execution Mode

Upon terraform initialization, make sure to:

1. YOUR_ORGANIZATION_NAME > Workspaces >YOUR_WORKSPACE_NAME > Settings > General
1. Switch `Execution Mode`from `Remote` to `Local`
1. Save the settings
