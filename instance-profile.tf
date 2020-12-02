locals {
  instance_profile_enabled = local.enabled && var.instance_profile == null
  aws_policy_prefix        = format("arn:%s:iam::aws:policy", join("", data.aws_partition.current.*.partition))
}

data "aws_partition" "current" {
  count = local.instance_profile_enabled ? 1 : 0
}

data "aws_iam_policy_document" "assume_role" {
  count = local.instance_profile_enabled ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

module "worker_label" {
  source  = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.21.0"
  enabled = local.instance_profile_enabled

  attributes = ["worker"]

  context = module.this.context
}

resource "aws_iam_instance_profile" "worker" {
  count = local.instance_profile_enabled ? 1 : 0
  name  = module.worker_label.id
  role  = join("", aws_iam_role.worker.*.name)
}
resource "aws_iam_role" "worker" {
  count              = local.instance_profile_enabled ? 1 : 0
  name               = module.worker_label.id
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
  tags               = module.worker_label.tags
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  count      = local.instance_profile_enabled ? 1 : 0
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEKSWorkerNodePolicy")
  role       = join("", aws_iam_role.worker.*.name)
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  count      = local.instance_profile_enabled ? 1 : 0
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEKS_CNI_Policy")
  role       = join("", aws_iam_role.worker.*.name)
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  count      = local.instance_profile_enabled ? 1 : 0
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEC2ContainerRegistryReadOnly")
  role       = join("", aws_iam_role.worker.*.name)
}

resource "aws_iam_role_policy_attachment" "existing_policies_for_eks_workers_role" {
  for_each   = local.instance_profile_enabled ? toset(var.existing_workers_role_policy_arns) : []
  policy_arn = each.value
  role       = join("", aws_iam_role.worker.*.name)
}
