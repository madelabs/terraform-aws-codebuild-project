resource "aws_codebuild_project" "main" {
  name          = var.codebuild_project_name
  description   = var.codebuild_project_description
  build_timeout = var.codebuild_build_timeout

  service_role         = local.service_role_arn
  resource_access_role = local.service_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = var.codebuild_compute_type
    type         = var.codebuild_type

    image                       = var.codebuild_image
    image_pull_credentials_type = var.codebuild_image_pull_credentials_type

    privileged_mode = var.privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  source_version = var.github_repo_branch

  source {
    type      = "GITHUB"
    location  = var.github_repo_url
    buildspec = var.buildspec
  }

  dynamic "vpc_config" {
    for_each = var.vpc_access_enabled ? [1] : []
    content {
      vpc_id             = var.vpc_id
      subnets            = var.vpc_subnets
      security_group_ids = var.vpc_security_group_ids
    }
  }
}
