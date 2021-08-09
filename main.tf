locals {
  enabled            = module.this.enabled
  cluster_name       = var.eks_cluster_id
  controller_id      = var.ocean_controller_id == null ? local.cluster_name : var.ocean_controller_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids

  default_tags = {
    Name : "${local.cluster_name}-ocean-cluster-node"
    "kubernetes.io/cluster/${local.cluster_name}" : "owned"
  }
}

resource "spotinst_ocean_aws" "this" {
  count      = local.enabled ? 1 : 0
  depends_on = [var.module_depends_on]

  name                        = local.cluster_name
  controller_id               = local.controller_id
  region                      = var.region
  max_size                    = var.max_size
  min_size                    = var.min_size
  desired_capacity            = var.desired_capacity
  subnet_ids                  = local.subnet_ids
  image_id                    = local.ami_id
  whitelist                   = var.instance_types
  root_volume_size            = var.disk_size
  security_groups             = local.security_group_ids
  key_name                    = var.ec2_ssh_key
  iam_instance_profile        = var.instance_profile == null ? join("", aws_iam_instance_profile.worker.*.name) : var.instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = local.userdata
  fallback_to_ondemand        = var.fallback_to_ondemand

  dynamic "tags" {
    for_each = merge(local.default_tags, module.this.tags)
    content {
      key   = tags.key
      value = tags.value
    }
  }

  autoscaler {
    autoscale_is_enabled     = true
    autoscale_is_auto_config = true
  }

  update_policy {
    should_roll = var.update_policy_should_roll

    roll_config {
      batch_size_percentage = var.update_policy_batch_size_percentage
    }
  }

  instance_metadata_options {
    http_tokens                 = var.metadata_http_tokens_required ? "required" : "optional"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
