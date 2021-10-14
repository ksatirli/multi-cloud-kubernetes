# See https://registry.terraform.io/modules/devops-rob/transit-secrets-engine/vault/latest

module "transit_secrets_engine" {
  source  = "devops-rob/transit-secrets-engine/vault"
  version = "0.1.0"

  transit_keys = [
    {
      name                   = "expense_report_service"
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

resource "vault_policy" "report_service_decryptor" {
  name = "report_service_decryptor"

  policy = <<EOF
path "transit/decrypt/expense_report_service" {
   capabilities = [ "update" ]
}
EOF

}

resource "vault_policy" "expense_service_encryptor" {
  name = "expense_service_encryptor"

  policy = <<EOF
path "transit/encrypt/expense_report_service" {
   capabilities = [ "update" ]
}
EOF

}

# see https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend
resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"

  tune {
    max_lease_ttl      = "90000s"
    listing_visibility = "unauth"
  }


}

# see https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_config

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc"
  kubernetes_ca_cert     = data.kubernetes_secret.vault.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.vault.data["token"]
  issuer                 = "kubernetes/serviceaccount"
  disable_iss_validation = "true"
}

# see https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role
resource "vault_kubernetes_auth_backend_role" "expense_service" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "expense"
  bound_service_account_names      = ["expense"]
  bound_service_account_namespaces = ["default"]
  token_ttl                        = 3600
  token_policies = [
    vault_policy.expense_service_encryptor.name,
  ]
}

resource "vault_kubernetes_auth_backend_role" "report_service" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "report"
  bound_service_account_names      = ["report"]
  bound_service_account_namespaces = ["default"]
  token_ttl                        = 3600
  token_policies = [
    vault_policy.report_service_decryptor.name,
  ]
}