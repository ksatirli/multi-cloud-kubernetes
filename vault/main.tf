module "vault_on_doks" {
  source = "modules/vault"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }
}

