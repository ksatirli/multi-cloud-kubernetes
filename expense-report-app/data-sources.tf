data "kubernetes_service_account" "vault" {
  metadata {
    name = "vault"
  }
}

data "kubernetes_secret" "vault" {
  metadata {
    name      = data.kubernetes_service_account.vault.default_secret_name
    namespace = "default"
  }
}

data "kubernetes_secret" "ca" {
  metadata {
    name      = data.kubernetes_service_account.vault.default_secret_name
    namespace = "default"
  }
}

data "terraform_remote_state" "clusters" {
  backend = "remote"

  config = {
    organization = "a-demo-organization"


    workspaces = {
      name = "multi-cloud-k8s-outputs"
    }
  }
}

data "digitalocean_kubernetes_cluster" "kubernetes" {
  name = data.terraform_remote_state.clusters.outputs.clusters.doks.cluster_name
}

data "kubernetes_service" "vault" {
  metadata {
    name = "vault-public"
  }
}