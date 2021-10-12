# see https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.20.0"

  cluster_name    = var.tfe_workspaces_prefix
  cluster_version = "1.20"
  manage_aws_auth = false

  subnets = [
    data.aws_subnet.default["a"].id,
    data.aws_subnet.default["c"].id,
  ]

  worker_groups = [{
    name                 = "worker-group-1"
    instance_type        = "t2.large"
    asg_desired_capacity = 3
    }
  ]

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  write_kubeconfig = false
  vpc_id           = data.aws_vpc.default.id
}
