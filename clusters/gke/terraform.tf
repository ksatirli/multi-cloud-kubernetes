terraform {
  # see https://www.terraform.io/docs/language/settings/backends/remote.html
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "a-demo-organization"

    workspaces {
      name = "multi-cloud-k8s-gke"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/google/5.18.0
    google = {
      source  = "hashicorp/google"
      version = "5.18.0"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-a-required-terraform-version
  required_version = "1.0.9"
}
