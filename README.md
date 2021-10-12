# Multi-Cloud Kubernetes

> This repository is a multi-cloud setup of Kubernetes Clusters to run HashiCorp Consul, and Vault.

## Table of Contents

- [Multi-Cloud Kubernetes](#multi-cloud-kubernetes)
  - [Table of Contents](#table-of-contents)
  - [Workflows](#workflows)
  - [Author Information](#author-information)
  - [License](#license)

## Workflows

The code in this repository is split out into a handful of distinct workflows, each in their own directory.

### Cluster Workflows

* `./clusters/aks` contains code for Azure AKS Clusters
* `./clusters/eks` contains code for AWS EKS Clusters
* `./clusters/doks` contains code for Digital Ocean Kubernetes Clusters
* `./clusters/gke` contains code for Google Cloud GKE Clusters

### Workload Workflows

* `./consul` contains configuration for deploying [HashiCorp Consul](https://www.consul.io)
  * `./consul/modules/grafana` contains configuration for deploying [Grafana](https://grafana.com)
  * `./consul/modules/jaeger` contains configuration for deploying [Jaeger](https://www.jaegertracing.io)
* `./vault` contains configuration for deploying [HashiCorp Vault](https://www.vaultproject.io)

### Other Workflows

* `outputs` contains code for collecting distinctive outputs from all Workspaces in this repository
* `workspaces` contains code for Terraform Cloud Workspaces

Each directory contains its own `README.md` with information relevant to the workflow.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/multi-cloud-kubernetes/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
