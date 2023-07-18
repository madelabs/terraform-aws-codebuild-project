module "example_project" {
  source  = "madelabs/codebuild-project/aws"
  version = "0.0.1"

  codebuild_project_name        = "example"
  codebuild_project_description = "Build the example project"
  github_repo_branch            = "main"
  buildspec                     = "buildspec.yml"
  github_repo_url               = "https://github.com/example/example-project.git"
}
