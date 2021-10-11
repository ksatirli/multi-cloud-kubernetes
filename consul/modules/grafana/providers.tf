terraform {
  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/helm/2.3.0/docs
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/kubernetes/2.5.0/docs
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
  }
}
