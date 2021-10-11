module "vault_on_doks" {
  source = "./modules/vault"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }

  # NOTE: this is NOT the version of Vault to use
  # see https://github.com/hashicorp/vault-helm/tags
  chart_version = "0.16.1"
}

#module "vault_on_gke" {
#  source = "./modules/vault"
#
#  providers = {
#    helm       = helm.gke
#    kubernetes = kubernetes.gke
#  }
#}
