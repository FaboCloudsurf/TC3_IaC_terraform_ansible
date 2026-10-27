# Values needed in the next steps:
#   state_bucket -> backend block in terraform/
#   ci_role_arn  -> GitHub repository variable used by the workflow
output "state_bucket" {
  value = aws_s3_bucket.tf_state.bucket
}

output "ci_role_arn" {
  value = aws_iam_role.github_actions.arn
}