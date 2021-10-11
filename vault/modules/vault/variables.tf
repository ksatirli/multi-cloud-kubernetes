variable "chart_version" {
  type        = string
  description = "Specify the exact chart version to install."
  default     = "0.16.1"
}

variable "vault_dev_root_token" {
  type        = string
  description = "Vault root token for development mode."
}

variable "add_to_service_mesh" {
  type        = bool
  description = "Run Vault as part of Consul service mesh."
  default     = true
}
