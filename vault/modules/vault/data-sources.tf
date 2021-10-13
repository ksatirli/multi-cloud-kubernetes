data "kubernetes_service_account" "vault" {
  metadata {
    name = "vault"
  }
}

data "kubernetes_secret" "vault" {
  metadata {
    name = data.kubernetes_service_account.vault.default_secret_name
    namespace = "default"
  }
}

data "kubernetes_secret" "ca" {
  metadata {
    name = data.kubernetes_service_account.vault.default_secret_name
    namespace = "default"
  }
}