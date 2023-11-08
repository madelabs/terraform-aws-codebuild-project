# terraform-aws-codebuild-project

<!-- BEGIN MadeLabs Header -->
![MadeLabs is for hire!](https://d2xqy67kmqxrk1.cloudfront.net/horizontal_logo_white.png)
MadeLabs is proud to support the open source community with these blueprints for provisioning infrastructure to help software builders get started quickly and with confidence. 

We're also for hire: [https://www.madelabs.io](https://www.madelabs.io)

<!-- END MadeLabs Header -->
---

A Terraform module for managing a simple CodeBuild project.

![PlantUML model](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/madelabs/terraform-aws-codebuild-project/main/docs/diagram.puml)

## Requirements

- An existing GitHub connection available within the CodeBuild console.  This module does not support CodeStar connections.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_iam_policy.codebuild_extra_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_extra_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.codebuild_assume_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | Location in repo of buildspec, specifiy for project specific buildspec | `string` | n/a | yes |
| <a name="input_codebuild_build_timeout"></a> [codebuild\_build\_timeout](#input\_codebuild\_build\_timeout) | The number of minutes until the CodeBuild project times-out. | `number` | `5` | no |
| <a name="input_codebuild_compute_type"></a> [codebuild\_compute\_type](#input\_codebuild\_compute\_type) | The compute type for the CodeBuild project.  This module supports: BUILD\_GENERAL1\_SMALL, BUILD\_GENERAL1\_MEDIUM, or BUILD\_GENERAL1\_LARGE | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest). | `string` | `"aws/codebuild/standard:6.0"` | no |
| <a name="input_codebuild_image_pull_credentials_type"></a> [codebuild\_image\_pull\_credentials\_type](#input\_codebuild\_image\_pull\_credentials\_type) | Type of credentials AWS CodeBuild uses to pull images in your build. Valid values: CODEBUILD, SERVICE\_ROLE. When you use a cross-account or private registry image, you must use SERVICE\_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CodeBuild credentials. | `string` | `"CODEBUILD"` | no |
| <a name="input_codebuild_project_description"></a> [codebuild\_project\_description](#input\_codebuild\_project\_description) | The description of the CodeBuild project. | `string` | n/a | yes |
| <a name="input_codebuild_project_name"></a> [codebuild\_project\_name](#input\_codebuild\_project\_name) | The name of the CodeBuild project. | `string` | n/a | yes |
| <a name="input_codebuild_service_role_arn"></a> [codebuild\_service\_role\_arn](#input\_codebuild\_service\_role\_arn) | The service role arn the codebuild will use. If not provided, a new IAM role will be created for the codebuild. | `string` | `""` | no |
| <a name="input_codebuild_type"></a> [codebuild\_type](#input\_codebuild\_type) | The environment type for the CodeBuild project.  This module supports: LINUX\_CONTAINER and ARM\_CONTAINER. | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_enable_extra_iam_permissions"></a> [enable\_extra\_iam\_permissions](#input\_enable\_extra\_iam\_permissions) | Whether or not to enable the extra permissions described in extra\_iam\_permissions\_json. | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The environment variables to create for the CodeBuild project. | <pre>list(object({<br>    name  = string,<br>    value = string,<br>    type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_extra_iam_permissions_json_file"></a> [extra\_iam\_permissions\_json\_file](#input\_extra\_iam\_permissions\_json\_file) | The JSON filename relative to the root Terraform module that contains JSON formatted IAM policy to apply to the role. | `string` | `"extra-iam-permissions.json"` | no |
| <a name="input_github_repo_branch"></a> [github\_repo\_branch](#input\_github\_repo\_branch) | The branch of the repository that will trigger the pipeline. | `string` | n/a | yes |
| <a name="input_github_repo_url"></a> [github\_repo\_url](#input\_github\_repo\_url) | The .git URL to the source GitHub repository. | `string` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| <a name="input_vpc_access_enabled"></a> [vpc\_access\_enabled](#input\_vpc\_access\_enabled) | Whether or not access to a VPC is enabled. | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of a VPC thie project will connect to. | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | The IDs of the security groups for the CodeBuild project. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_vpc_subnets"></a> [vpc\_subnets](#input\_vpc\_subnets) | The IDs of the VPC subnets for the CodeBuild project. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_arn"></a> [codebuild\_arn](#output\_codebuild\_arn) | n/a |
| <a name="output_codebuild_id"></a> [codebuild\_id](#output\_codebuild\_id) | n/a |
<!-- END_TF_DOCS -->