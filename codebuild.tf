resource "aws_codebuild_project" "main" {
  name          = var.codebuild_project_name
  description   = var.codebuild_project_description
  build_timeout = var.codebuild_build_timeout

  service_role         = aws_iam_role.codebuild_role.arn
  resource_access_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.codebuild_compute_type
    image           = var.codebuild_image
    type            = var.codebuild_type
    privileged_mode = true
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
