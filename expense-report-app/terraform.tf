# see https://www.terraform.io/docs/language/settings/backends/remote.html

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "a-demo-organization"

    workspaces {
      name = "multi-cloud-expense-report-app"
    }
  }
}