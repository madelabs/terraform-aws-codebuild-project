locals {
  service_role_provided = var.codebuild_service_role_arn != ""
  service_role_arn = local.service_role_provided ? var.codebuild_service_role_arn : aws_iam_role.codebuild_role[0].arn 
}