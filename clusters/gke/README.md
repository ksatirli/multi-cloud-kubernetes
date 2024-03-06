# Workspace `gke`

> This directory contains [Google Cloud](https://registry.terraform.io/providers/hashicorp/google/) Resources.

## Requirements

* Terraform CLI `1.0.8` or newer
* a Google Cloud account

## Downstream Consumption

The Kubernetes Cluster can be consumed via the [google_container_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster
data "google_container_cluster" "cluster" {
  name     = "multi-cloud-k8s"
  location = "us-west2"
}
```

## Notes

The implementation of this GKE Cluster is based on previous work carried out by [Bruno Schaatsbergen](https://github.com/bschaatsbergen/proxying-your-way-into-gke).
