# see https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "grafana" {
  chart      = "grafana"
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts/"

  # see https://github.com/grafana/helm-charts/tags
  version = var.chart_version # NOTE: this is NOT the version of Grafana to use

  values = [
    file("${path.module}/values.yml")
  ]
}
