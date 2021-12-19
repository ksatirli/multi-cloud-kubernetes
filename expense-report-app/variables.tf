variable "vault_dev_root_token" {
  type        = string
  description = "Vault root token for development mode."
  sensitive   = true
}
//
//variable "tfe_workspaces_name" {
//  type        = string
//  description = "TFC workspace name"
//}

variable "do_token" {
  type        = string
  description = "This is the DO API token."
  sensitive   = true
}
