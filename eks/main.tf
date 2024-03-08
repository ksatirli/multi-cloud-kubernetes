# see https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.5.0"

  cluster_name    = var.tfe_workspaces_prefix
  cluster_version = "1.29"

  # see https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html
  cluster_addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent    = true
      before_compute = true

      # see https://developer.hashicorp.com/terraform/language/functions/jsonencode
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  # see https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true
  enable_efa_support                       = true

  subnet_ids = [
    data.aws_subnet.default["a"].id,
    data.aws_subnet.default["b"].id,
  ]

  vpc_id = data.aws_vpc.default.id

}
