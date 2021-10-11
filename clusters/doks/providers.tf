# see https://registry.terraform.io/providers/digitalocean/digitalocean/latest
provider "digitalocean" {
  token        = var.do_token
  api_endpoint = "https://api.digitalocean.com"
}
