# Vault `doks`

> This directory contains [Digital Ocean](https://registry.terraform.io/providers/digitalocean/digitalocean) Resources.

## Requirements

* Terraform CLI `1.0.8` or newer
* a Digital Ocean [account](https://m.do.co/c/b73b4af31c09)

## Deployment

This deploys the following components to a Digital Ocean Kubernetes cluster.

- Vault in dev mode (via Helm chart). Adds to Consul service mesh by default.