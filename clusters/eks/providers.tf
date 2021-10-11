# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
