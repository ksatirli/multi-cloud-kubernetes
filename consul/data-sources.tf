# see https://www.terraform.io/docs/language/state/remote-state-data.html#example-usage-remote-backend-
data "terraform_remote_state" "clusters" {
  backend = "remote"

  config = {
    organization = "a-demo-organization"

    workspaces = {
      name = "multi-cloud-k8s-outputs"
    }
  }
}

# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster
data "digitalocean_kubernetes_cluster" "cluster" {
  # dynamically retrieve the DOKS Cluster Name from Terraform State from the `outputs` Workspace
  name = data.terraform_remote_state.clusters.outputs.clusters.doks.cluster_name
}
