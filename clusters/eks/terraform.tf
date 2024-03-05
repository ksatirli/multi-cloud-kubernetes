terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    hostname     = "app.terraform.io"
    organization = "a-demo-organization"

    workspaces {
      name = "multi-cloud-k8s-eks"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/5.39.1/docs
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = "1.7.4"
}
