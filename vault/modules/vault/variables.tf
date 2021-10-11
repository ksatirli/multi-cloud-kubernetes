variable "chart_version" {
  type        = string
  description = "Specify the exact chart version to install."

  # NOTE: this is NOT the version of Vault to use
  # see https://github.com/hashicorp/vault-helm/tags
  default = "0.16.1"
}
