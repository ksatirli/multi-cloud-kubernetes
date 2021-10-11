module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.20.0"

  cluster_name    = var.tfe_workspaces_prefix
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = data.aws

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [{
    name                          = "worker-group-1"
    instance_type                 = "t2.large"
    asg_desired_capacity          = 1
    }
  ]
}
