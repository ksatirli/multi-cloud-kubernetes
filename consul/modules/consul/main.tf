# see https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "consul" {
  chart      = "consul"
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com/"

  # see https://github.com/hashicorp/consul-k8s/tags
  version = var.chart_version # NOTE: this is NOT the version of Consul to use

  values = [
    file("${path.module}/values.yml")
  ]
}
