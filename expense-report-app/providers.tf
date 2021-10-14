terraform {
  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/kubernetes/2.5.0/docs
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/vault/latest/docs
    vault = {
      source  = "hashicorp/vault"
      version = "2.24.1"
    }

    # see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  # see https://www.terraform.io/docs/language/providers/configuration.html#alias-multiple-provider-configurations
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.kubernetes.kube_config[0].cluster_ca_certificate)
  host                   = data.digitalocean_kubernetes_cluster.kubernetes.endpoint
  token                  = data.digitalocean_kubernetes_cluster.kubernetes.kube_config[0].token
}

provider "digitalocean" {
  token        = var.do_token
  api_endpoint = "https://api.digitalocean.com"
}

provider "vault" {
  address = "http://${data.kubernetes_service.vault.status.0.load_balancer.0.ingress.0.ip}:8200"
  token   = var.vault_dev_root_token
}

