data "aws_iam_policy_document" "codebuild_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codebuild_policy_document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterfacePermission"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  count  = local.service_role_provided ? 0 : 1
  name   = "${var.codebuild_project_name}-codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy_document.json
}

resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  count      = local.service_role_provided ? 0 : 1
  role       = aws_iam_role.codebuild_role[0].name
  policy_arn = aws_iam_policy.codebuild_policy[0].arn
}

resource "aws_iam_role" "codebuild_role" {
  count                = local.service_role_provided ? 0 : 1
  name                 = "${var.codebuild_project_name}-codebuild-role"
  assume_role_policy   = data.aws_iam_policy_document.codebuild_assume_role_policy_document.json
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
}

resource "aws_iam_policy" "codebuild_extra_policy" {
  count  = !local.service_role_provided && var.enable_extra_iam_permissions ? 1 : 0
  name   = "${var.codebuild_project_name}-extra-codebuild-policy"
  policy = file("./${var.extra_iam_permissions_json_file}")
}

resource "aws_iam_role_policy_attachment" "codebuild_extra_attachment" {
  count      = !local.service_role_provided && var.enable_extra_iam_permissions ? 1 : 0
  role       = aws_iam_role.codebuild_role[0].name
  policy_arn = aws_iam_policy.codebuild_extra_policy[0].arn
}