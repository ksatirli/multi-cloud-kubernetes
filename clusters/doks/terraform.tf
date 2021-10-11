terraform {
  # see https://www.terraform.io/docs/language/settings/backends/remote.html
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "a-demo-organization"

    workspaces {
      name = "multi-cloud-k8s-doks"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/digitalocean/digitalocean/2.14.0
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.14.0"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-a-required-terraform-version
  required_version = "1.0.8"
}
