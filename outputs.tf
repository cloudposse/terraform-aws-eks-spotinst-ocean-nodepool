output "ocean_controller_id" {
  description = "The ID of the Ocean controller"
  value       = local.controller_id
}

output "worker_arn" {
  description = "The ARN of the role for worker instances"
  value       = join("", aws_iam_role.worker.*.arn)
}
