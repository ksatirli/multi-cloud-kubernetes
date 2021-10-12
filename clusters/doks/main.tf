# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster
resource "digitalocean_kubernetes_cluster" "cluster" {
  auto_upgrade = false

  maintenance_policy {
    start_time = "03:00"
    day        = "monday"
  }

  name = var.tfe_workspaces_prefix

  node_pool {
    name       = "worker-pool"
    size       = "s-4vcpu-8gb"
    node_count = 3
  }

  region = var.do_region

  # see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#version
  version = data.digitalocean_kubernetes_versions.cluster.latest_version
}
