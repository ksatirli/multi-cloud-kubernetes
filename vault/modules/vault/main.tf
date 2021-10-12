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

# See https://registry.terraform.io/modules/devops-rob/transit-secrets-engine/vault/latest

module "transit_secrets_engine" {
  source  = "devops-rob/transit-secrets-engine/vault"
  version = "0.1.0"

  transit_keys = [
    {
      name                   = "payments_service"
      allow_plaintext_backup = false
      convergent_encryption  = false
      exportable             = false
      deletion_allowed       = true
      derived                = false
      type                   = "rsa-2048"
      min_decryption_version = 1
      min_encryption_version = 1
    }
  ]
}

resource "vault_policy" "payments_service_encryptor" {
  name = "payments_service_encryptor"

  policy = <<EOF
path "transit/encrypt/payments_service" {
   capabilities = [ "update" ]
}
EOF
}

resource "vault_policy" "payments_service_decryptor" {
  name = "payments_service_decryptor"

  policy = <<EOF
path "transit/decrypt/payments_service" {
   capabilities = [ "update" ]
}
EOF
}