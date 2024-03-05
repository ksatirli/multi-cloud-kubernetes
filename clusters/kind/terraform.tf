terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    hostname     = "app.terraform.io"
    organization = "a-demo-organization"

    workspaces {
      name = "multi-cloud-k8s-kind"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/kyma-incubator/kind/0.0.11
    kind = {
      source  = "kyma-incubator/kind"
      version = "0.0.11"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = "1.7.4"
}
