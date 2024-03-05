# Multi-Cloud Kubernetes

> This repository is a multi-cloud setup of Kubernetes Clusters to run HashiCorp Consul, and Vault.

## Table of Contents

<!-- TOC -->
* [Multi-Cloud Kubernetes](#multi-cloud-kubernetes)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Workflows](#workflows)
    * [Cluster Workflows](#cluster-workflows)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* Terraform `1.7.0` or [newer](https://developer.hashicorp.com/terraform/downloads).
* Terraform Cloud [Account](https://app.terraform.io/session)

* one or more service provider accounts:
  * AWS [account](https://aws.amazon.com/account/) for `clusters/eks`
  * DigitalOcean [account](https://m.do.co/c/53544ec84215) for `clusters/doks`
  * Microsoft Azure [account](https://azure.microsoft.com/free) for `clusters/aks`
  * Google Cloud [account](https://console.cloud.google.com/) for `clusters/gke`

## Workflows

The code in this repository is split out into a handful of distinct workflows, each in their own directory.

### Cluster Workflows

* `./clusters/aks` contains code for Azure AKS Clusters
* `./clusters/eks` contains code for AWS EKS Clusters
* `./clusters/doks` contains code for Digital Ocean Kubernetes Clusters
* `./clusters/gke` contains code for Google Cloud GKE Clusters
* `./clusters/kind` contains code for Kubernetes in Docker (kind) Clusters

Each directory contains its own `README.md` with information relevant to the workflow.

## Notes

* By default,

* A previous version of this repository featured Consul and Vault deployments. The code for this is accessible via the [`v1` Tag](https://github.com/ksatirli/multi-cloud-kubernetes/releases/tag/v1).

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/multi-cloud-kubernetes/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
