module "consul_on_doks" {
  source = "./modules/consul"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }

  # NOTE: this is NOT the version of Vault to use
  chart_version = "0.34.1"
}

#module "consul_on_gke" {
#  source = "./modules/consul"
#
#  providers = {
#    helm       = helm.gke
#    kubernetes = kubernetes.gke
#  }
#}
