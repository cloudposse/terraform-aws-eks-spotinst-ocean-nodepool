output "ocean_controller_id" {
  description = "The ID of the Ocean controller"
  value       = local.controller_id
}

output "worker_role_arn" {
  description = "The ARN of the role for worker instances, if created by this module (`var.instance_profile == null`)"
  value       = local.enabled && var.instance_profile == null ? join("", aws_iam_role.worker.*.arn) : null
}
