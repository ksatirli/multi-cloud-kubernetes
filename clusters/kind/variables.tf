variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

# see https://github.com/kubernetes-sigs/kind/releases
variable "kind_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use with Kind Cluster."
  default     = "v1.21.1"
}

variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "~/.kube/config"
}
