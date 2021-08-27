<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.18 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |
| <a name="requirement_spotinst"></a> [spotinst](#requirement\_spotinst) | >= 1.56 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.18 |
| <a name="provider_spotinst"></a> [spotinst](#provider\_spotinst) | >= 1.56 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |
| <a name="module_worker_label"></a> [worker\_label](#module\_worker\_label) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.existing_policies_for_eks_workers_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [spotinst_ocean_aws.this](https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/ocean_aws) | resource |
| [aws_ami.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_after_cluster_joining_userdata"></a> [after\_cluster\_joining\_userdata](#input\_after\_cluster\_joining\_userdata) | Additional `bash` commands to execute on each worker node after joining the EKS cluster (after executing the `bootstrap.sh` script). For more info, see https://kubedex.com/90-days-of-aws-eks-in-production | `string` | `""` | no |
| <a name="input_ami_image_id"></a> [ami\_image\_id](#input\_ami\_image\_id) | AMI to use. Ignored of `launch_template_id` is supplied. | `string` | `null` | no |
| <a name="input_ami_release_version"></a> [ami\_release\_version](#input\_ami\_release\_version) | EKS AMI version to use, e.g. "1.16.13-20200821" (no "v"). Defaults to latest version for Kubernetes version. | `string` | `null` | no |
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | Type of Amazon Machine Image (AMI) associated with the Ocean.<br>Defaults to `AL2_x86_64`. Valid values: `AL2_x86_64`, `AL2_x86_64_GPU`, and `AL2_ARM_64`. | `string` | `"AL2_x86_64"` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public IP address to worker nodes | `bool` | `false` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_before_cluster_joining_userdata"></a> [before\_cluster\_joining\_userdata](#input\_before\_cluster\_joining\_userdata) | Additional `bash` commands to execute on each worker node before joining the EKS cluster (before executing the `bootstrap.sh` script). For more info, see https://kubedex.com/90-days-of-aws-eks-in-production | `string` | `""` | no |
| <a name="input_bootstrap_additional_options"></a> [bootstrap\_additional\_options](#input\_bootstrap\_additional\_options) | Additional options to bootstrap.sh. DO NOT include `--kubelet-additional-args`, use `kubelet_additional_args` var instead. | `string` | `""` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of worker nodes to launch and maintain in the Ocean cluster | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GiB for worker nodes. Defaults to 20. Ignored it `launch_template_id` is supplied.<br>Terraform will only perform drift detection if a configuration value is provided. | `number` | `20` | no |
| <a name="input_ec2_ssh_key"></a> [ec2\_ssh\_key](#input\_ec2\_ssh\_key) | SSH key pair name to use to access the worker nodes launced by Ocean | `string` | `null` | no |
| <a name="input_eks_cluster_id"></a> [eks\_cluster\_id](#input\_eks\_cluster\_id) | EKS Cluster identifier | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_existing_workers_role_policy_arns"></a> [existing\_workers\_role\_policy\_arns](#input\_existing\_workers\_role\_policy\_arns) | List of existing policy ARNs that will be attached to the workers default role on creation | `list(string)` | `[]` | no |
| <a name="input_fallback_to_ondemand"></a> [fallback\_to\_ondemand](#input\_fallback\_to\_ondemand) | If no Spot instance markets are available, enable Ocean to launch On-Demand instances instead. | `bool` | `true` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | The AWS Instance Profile to use for Spotinst Worker instances. If not set, one will be created. | `string` | `null` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of instance type to use for this node group. Defaults to null, which allows all instance types. | `list(string)` | `null` | no |
| <a name="input_kubelet_additional_options"></a> [kubelet\_additional\_options](#input\_kubelet\_additional\_options) | Additional flags to pass to kubelet.<br>DO NOT include `--node-labels` or `--node-taints`,<br>use `kubernetes_labels` and `kubernetes_taints` to specify those." | `string` | `""` | no |
| <a name="input_kubernetes_labels"></a> [kubernetes\_labels](#input\_kubernetes\_labels) | Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument.<br>Other Kubernetes labels applied to the EKS Node Group will not be managed. | `map(string)` | `{}` | no |
| <a name="input_kubernetes_taints"></a> [kubernetes\_taints](#input\_kubernetes\_taints) | Key-value mapping of Kubernetes taints. | `map(string)` | `{}` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version. Required unless `ami_image_id` is provided. | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The upper limit of worker nodes the Ocean cluster can scale up to | `number` | `null` | no |
| <a name="input_metadata_http_put_response_hop_limit"></a> [metadata\_http\_put\_response\_hop\_limit](#input\_metadata\_http\_put\_response\_hop\_limit) | The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests. | `number` | `2` | no |
| <a name="input_metadata_http_tokens_required"></a> [metadata\_http\_tokens\_required](#input\_metadata\_http\_tokens\_required) | Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2. | `bool` | `true` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The lower limit of worker nodes the Ocean cluster can scale down to | `number` | `1` | no |
| <a name="input_module_depends_on"></a> [module\_depends\_on](#input\_module\_depends\_on) | Can be any value desired. Module will wait for this value to be computed before creating node group. | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_ocean_controller_id"></a> [ocean\_controller\_id](#input\_ocean\_controller\_id) | Ocean Cluster identifier, used by cluster controller to target this cluster. If unset, will use EKS cluster identifier | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security groups that will be attached to the autoscaling group | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to launch resources in | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_update_policy_batch_size_percentage"></a> [update\_policy\_batch\_size\_percentage](#input\_update\_policy\_batch\_size\_percentage) | When rolling the cluster due to an update, the percentage of the instances to deploy in each batch. | `number` | `25` | no |
| <a name="input_update_policy_should_roll"></a> [update\_policy\_should\_roll](#input\_update\_policy\_should\_roll) | If true, roll the cluster when its configuration is updated | `bool` | `true` | no |
| <a name="input_userdata_override_base64"></a> [userdata\_override\_base64](#input\_userdata\_override\_base64) | Many features of this module rely on the `bootstrap.sh` provided with Amazon Linux, and this module<br>may generate "user data" that expects to find that script. If you want to use an AMI that is not<br>compatible with the Amazon Linux `bootstrap.sh` initialization, then use `userdata_override_base64` to provide<br>your own (Base64 encoded) user data. Use "" to prevent any user data from being set.<br><br>Setting `userdata_override_base64` disables `kubernetes_taints`, `kubelet_additional_options`,<br>`before_cluster_joining_userdata`, `after_cluster_joining_userdata`, and `bootstrap_additional_options`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ocean_controller_id"></a> [ocean\_controller\_id](#output\_ocean\_controller\_id) | The ID of the Ocean controller |
| <a name="output_worker_role_arn"></a> [worker\_role\_arn](#output\_worker\_role\_arn) | The ARN of the role for worker instances, if created by this module (`var.instance_profile == null`) |
<!-- markdownlint-restore -->
