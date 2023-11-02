variable "codebuild_project_name" {
  type        = string
  description = "The name of the CodeBuild project."
}

variable "codebuild_project_description" {
  type        = string
  description = "The description of the CodeBuild project."
}

variable "github_repo_branch" {
  type        = string
  description = "The branch of the repository that will trigger the pipeline."
}

variable "codebuild_image" {
  type        = string
  description = "Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
  default     = "aws/codebuild/standard:6.0"
}

variable "buildspec" {
  type        = string
  description = "Location in repo of buildspec, specifiy for project specific buildspec"
}

variable "codebuild_compute_type" {
  type        = string
  description = "The compute type for the CodeBuild project.  This module supports: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, or BUILD_GENERAL1_LARGE"
  default     = "BUILD_GENERAL1_SMALL"

  validation {
    condition     = var.codebuild_compute_type == "BUILD_GENERAL1_SMALL" || var.codebuild_compute_type == "BUILD_GENERAL1_MEDIUM" || var.codebuild_compute_type == "BUILD_GENERAL1_LARGE"
    error_message = "codebuild_compute_type must be one of: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, or BUILD_GENERAL1_LARGE."
  }
}

variable "codebuild_type" {
  type        = string
  description = "The environment type for the CodeBuild project.  This module supports: LINUX_CONTAINER and ARM_CONTAINER."
  default     = "LINUX_CONTAINER"

  validation {
    condition     = var.codebuild_type == "LINUX_CONTAINER" || var.codebuild_type == "ARM_CONTAINER"
    error_message = "codebuild_type must be one of: LINUX_CONTAINER or ARM_CONTAINER."
  }
}

variable "codebuild_build_timeout" {
  type        = number
  description = "The number of minutes until the CodeBuild project times-out."
  default     = 5
}

variable "github_repo_url" {
  type        = string
  description = "The .git URL to the source GitHub repository."
}

variable "vpc_access_enabled" {
  type        = bool
  default     = false
  description = "Whether or not access to a VPC is enabled."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of a VPC thie project will connect to."
}

variable "vpc_subnets" {
  type        = list(string)
  default     = [""]
  description = "The IDs of the VPC subnets for the CodeBuild project."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = [""]
  description = "The IDs of the security groups for the CodeBuild project."
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of the policy that is used to set the permissions boundary for the role."
  default     = ""
}

variable "environment_variables" {
  type = list(object({
    name  = string,
    value = string,
    type  = string
  }))
  description = "The environment variables to create for the CodeBuild project."
  default     = []

  validation {
    condition = alltrue([
      for obj in var.environment_variables : contains(["PARAMETER_STORE", "PLAINTEXT", "SECRETS_MANAGER"], obj.type)
    ])
    error_message = "Type can only be PARAMETER_STORE, PLAINTEXT, or SECRETS_MANAGER."
  }
}

variable "enable_extra_iam_permissions" {
  type        = bool
  description = "Whether or not to enable the extra permissions described in extra_iam_permissions_json."
  default     = false
}

variable "extra_iam_permissions_json_file" {
  description = "The JSON filename relative to the root Terraform module that contains JSON formatted IAM policy to apply to the role."
  type        = string
  default     = "extra-iam-permissions.json"

  validation {
    condition     = endswith(var.extra_iam_permissions_json_file, ".json")
    error_message = "The value of this variable must end with .json."
  }
}

variable "codebuild_image_pull_credentials_type" {
  type        = string
  description = "Type of credentials AWS CodeBuild uses to pull images in your build. Valid values: CODEBUILD, SERVICE_ROLE. When you use a cross-account or private registry image, you must use SERVICE_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CodeBuild credentials."
  default     = "CODEBUILD"

  validation {
    condition     = var.codebuild_image_pull_credentials_type == "CODEBUILD" || var.codebuild_image_pull_credentials_type == "SERVICE_ROLE"
    error_message = "codebuild_type must be one of: CODEBUILD or SERVICE_ROLE."
  }
}

variable "codebuild_service_role_arn" {
  type        = string
  description = "The service role arn the codebuild will use. If not provided, a new IAM role will be created for the codebuild."
  default = ""
}