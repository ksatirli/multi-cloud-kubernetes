# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest
provider "digitalocean" {
  token        = var.do_token
  api_endpoint = "https://api.digitalocean.com"
}

# see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
provider "kubernetes" {
  # see https://www.terraform.io/docs/language/providers/configuration.html#alias-multiple-provider-configurations
  alias = "doks"

  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
  host                   = data.digitalocean_kubernetes_cluster.cluster.endpoint
  token                  = data.digitalocean_kubernetes_cluster.cluster.kube_config[0].token
}

# see https://registry.terraform.io/providers/hashicorp/helm/latest/docs
provider "helm" {
  # see https://www.terraform.io/docs/language/providers/configuration.html#alias-multiple-provider-configurations
  alias = "doks"

  kubernetes {
    cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
    host                   = data.digitalocean_kubernetes_cluster.cluster.endpoint
    token                  = data.digitalocean_kubernetes_cluster.cluster.kube_config[0].token
  }
}
