# Vault on Digital Ocean Kubernetes Cluster
module "vault_on_doks" {
  source = "./modules/vault"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }
}

#module "vault_on_gke" {
#  source = "./modules/vault"
#
#  providers = {
#    helm       = helm.gke
#    kubernetes = kubernetes.gke
#  }
#}
