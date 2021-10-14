output "ocean_controller_id" {
  description = "The ID of the Ocean controller"
  value       = local.controller_id
}

output "ocean_id" {
  description = "The ID of the Ocean (o-123b567c), if created by this module (`local.enabled`)"
  value       = local.enabled ? join("", spotinst_ocean_aws.this.*.id) : null
}

output "worker_ami" {
  description = "The AMI ID that the worker instance uses, if determined by this module (`var.ami_image_id == null`)"
  value       = local.need_ami_id ? join("", data.aws_ami.selected.*.id) : null
}

output "worker_role_arn" {
  description = "The ARN of the role for worker instances, if created by this module (`var.instance_profile == null`)"
  value       = local.enabled && var.instance_profile == null ? join("", aws_iam_role.worker.*.arn) : null
}

output "worker_role_name" {
  description = "The name of the role for worker instances, if created by this module (`var.instance_profile == null`)"
  value       = local.enabled && var.instance_profile == null ? join("", aws_iam_role.worker.*.name) : null
}

output "worker_instance_profile_arn" {
  description = "The ARN of the profile for worker instances, if created by this module (`var.instance_profile == null`)"
  value       = local.enabled && var.instance_profile == null ? join("", aws_iam_instance_profile.worker.*.arn) : null
}

output "worker_instance_profile_name" {
  description = "The name of the profile for worker instances, if created by this module (`var.instance_profile == null`)"
  value       = local.enabled && var.instance_profile == null ? join("", aws_iam_instance_profile.worker.*.name) : null
}
