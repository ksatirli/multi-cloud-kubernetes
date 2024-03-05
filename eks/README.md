# Workspace `EKS`

> This directory contains [AWS](https://registry.terraform.io/providers/hashicorp/aws) Resources.

## Requirements

* Terraform CLI `1.0.8` or newer
* an AWS [account](https://aws.amazon.com)

## Downstream Consumption

The Kubernetes Cluster can be consumed via the [aws_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) data source:

```hcl
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster
data "aws_eks_cluster" "cluster" {
  name = "multi-cloud-k8s"
}
```

The above example uses the default values for the `name` property. This may need to be changed for your situation.
