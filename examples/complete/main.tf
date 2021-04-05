module "eks_cluster_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  attributes = compact(concat(module.this.attributes, ["cluster"]))

  context = module.this.context
}

locals {
  # The usage of the specific kubernetes.io/cluster/* resource tags below are required
  # for EKS and Kubernetes to discover and manage networking resources
  # https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html#base-vpc-networking
  vpc_tags = merge(module.eks_cluster_label.tags, map("kubernetes.io/cluster/${module.eks_cluster_label.id}", "shared"))

  # required tags to make ALB ingress work https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
  public_subnets_additional_tags = {
    "kubernetes.io/role/elb" : 1
  }
  private_subnets_additional_tags = {
    "kubernetes.io/role/internal-elb" : 1
  }
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "0.21.1"

  cidr_block = "172.16.0.0/16"
  tags       = local.vpc_tags

  context = module.this.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "0.37.6"

  tags = local.vpc_tags

  availability_zones              = var.availability_zones
  cidr_block                      = module.vpc.vpc_cidr_block
  igw_id                          = module.vpc.igw_id
  nat_gateway_enabled             = false
  nat_instance_enabled            = true
  public_subnets_additional_tags  = local.public_subnets_additional_tags
  private_subnets_additional_tags = local.private_subnets_additional_tags
  vpc_id                          = module.vpc.vpc_id

  context = module.this.context
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "0.38.0"

  region                = var.region
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
  kubernetes_version    = var.kubernetes_version
  oidc_provider_enabled = true
  workers_role_arns     = [var.spotinst_workers_role_arn]

  context = module.this.context
}

module "spotinst_oceans" {
  source = "../.."

  attributes       = ["spotinst"]
  disk_size        = 20
  instance_profile = var.spotinst_instance_profile
  desired_capacity = 1
  min_size         = 1
  max_size         = 6

  eks_cluster_id      = module.eks_cluster.eks_cluster_id
  ocean_controller_id = module.eks_cluster.eks_cluster_id
  region              = var.region
  kubernetes_version  = var.kubernetes_version
  subnet_ids          = module.subnets.private_subnet_ids
  security_group_ids  = [module.eks_cluster.eks_cluster_managed_security_group_id]

  context = module.this.context
}
