variable "region" {
  type        = string
  description = "The AWS region in which to provision resources"
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "List of availability zones in which to provision VPC subnets"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.20"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "spotinst_instance_profile" {
  type        = string
  description = "The AWS Instance Profile to use for Spotinst Worker instances. If not set, one will be created."
  default     = null
}

variable "spotinst_workers_role_arn" {
  type        = string
  description = "The AWS Role ARN the Spotinst Worker instances will assume."
  default     = null
}

