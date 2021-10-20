# see https://registry.terraform.io/providers/kyma-incubator/kind/latest
resource "kind_cluster" "cluster" {
  name            = var.tfe_workspaces_prefix
  kubeconfig_path = pathexpand(var.kind_cluster_config_path)
  wait_for_ready  = true
  # see https://github.com/kubernetes-sigs/kind/releases
  node_image = "kindest/node:${var.kind_kubernetes_version}"
  # see https://github.com/kyma-incubator/terraform-provider-kind/blob/master/kind/structure_kind_config.go
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role = "control-plane"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]
      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }
    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
  }
}
