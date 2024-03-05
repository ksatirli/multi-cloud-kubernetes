# Workspace `doks`

> This directory contains [Digital Ocean](https://registry.terraform.io/providers/digitalocean/digitalocean) Resources.

## Requirements

* Terraform CLI `1.0.8` or newer
* a Digital Ocean [account](https://m.do.co/c/b73b4af31c09)

## Downstream Consumption

The Kubernetes Cluster can be consumed via the [digitalocean_kubernetes_cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster
data "digitalocean_kubernetes_cluster" "cluster" {
  name = "multi-cloud-k8s"
}
```

The above example uses the default values for the `name` property. This may need to be changed for your situation.
