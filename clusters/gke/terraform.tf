terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    hostname     = "app.terraform.io"
    organization = "a-demo-organization"

    workspaces {
      name = "multi-cloud-k8s-gke"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/google/5.19.0
    google = {
      source  = "hashicorp/google"
      version = "5.19.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = "1.7.4"
}
