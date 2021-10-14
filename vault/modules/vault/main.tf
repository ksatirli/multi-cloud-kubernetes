# see https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "vault" {
  chart      = "vault"
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com/"

  # see https://github.com/hashicorp/vault-helm/tags
  version = var.chart_version # NOTE: this is NOT the version of Vault to use

  values = [
    templatefile("${path.module}/values.yml", {
      dev_root_token = var.vault_dev_root_token
      add_to_service_mesh = var.add_to_service_mesh
    })
  ]
}

resource "kubernetes_service" "vault" {
  metadata {
    name = "vault-public"
  }
  spec {
    selector = {
      "app.kubernetes.io/name" = "vault"
      "component" = "server"
    }
    port {
      port        = 8200
      target_port = 8200
    }

    type = "LoadBalancer"
  }
}

