# Multi-Cloud Kubernetes

> This repository shows how to use HashiCorp Terraform to deploy Kubernetes on AWS, DigitalOcean, Microsoft Azure, and Google Cloud.

## Table of Contents

<!-- TOC -->
* [Multi-Cloud Kubernetes](#multi-cloud-kubernetes)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Cluster Workflows](#cluster-workflows)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* Terraform `1.7.4` or [newer](https://developer.hashicorp.com/terraform/downloads).
* Terraform Cloud [Account](https://app.terraform.io/session)

* one or more service provider accounts:
  * AWS [account](https://aws.amazon.com/account/) for `eks`
  * DigitalOcean [account](https://m.do.co/c/53544ec84215) for `doks`
  * Microsoft Azure [account](https://azure.microsoft.com/free) for `aks`
  * Google Cloud [account](https://console.cloud.google.com/) for `gke`

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

The code in this repository is split out into a handful of distinct workflows, each in their own directory.

### Cluster Workflows

* `./aks` contains code for Azure AKS clusters
* `./eks` contains code for AWS EKS clusters
* `./doks` contains code for DigitalOcean Kubernetes clusters
* `./gke` contains code for Google Cloud GKE clusters
* `./kind` contains code for Kubernetes in Docker (kind) Clusters

Each directory contains its own `README.md` with information relevant to the workflow.

## Notes

* By default, all Terraform state is stored in Terraform Cloud. This can be changed by modifying the `cloud` configuration in each `main.tf` file.

* A previous version of this repository featured Consul and Vault deployments. The code for this is accessible via the [`v1` Tag](https://github.com/ksatirli/multi-cloud-kubernetes/releases/tag/v1).

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/multi-cloud-kubernetes/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
