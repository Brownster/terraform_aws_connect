module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.4.0"

  role_name = "TerraformExecutionRole"

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_policy = true
  policies = {
    "s3_access" = aws_iam_policy.terraform_policy.arn
  }
}
