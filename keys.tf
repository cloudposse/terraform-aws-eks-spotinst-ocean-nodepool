//data "aws_ssm_parameter" "spotinst_token" {
//  count      = local.enabled ? 1 : 0
//  name = var.spotinst_token_ssm_key
//}
//data "aws_ssm_parameter" "spotinst_account" {
//  count      = local.enabled ? 1 : 0
//  name = var.spotinst_account_ssm_key
//}

//data "aws_ssm_parameter" "spotinst_external_id" {
//  count      = local.enabled && var.create_spotinst_iam_role ? 1 : 0
//  name = var.spotinst_external_id_ssm_key
//}
//
//locals {
////  spotinst_account = local.enabled ? data.aws_ssm_parameter.spotinst_account[0].value : null
////  spotinst_token = local.enabled ? data.aws_ssm_parameter.spotinst_token[0].value : null
//  spotinst_external_id = local.enabled && var.create_spotinst_iam_role ? data.aws_ssm_parameter.spotinst_external_id[0].value : null
//}
