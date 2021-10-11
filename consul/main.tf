module "consul_on_doks" {
  source = "./modules/consul"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }
}

module "grafana_on_doks" {
  source = "./modules/grafana"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }
}

module "jaeger_on_doks" {
  source = "./modules/jaeger"

  providers = {
    helm       = helm.doks
    kubernetes = kubernetes.doks
  }
}