# GitHub OIDC provider.
# Lets AWS trust identity tokens issued by GitHub Actions, so workflows get
# short-lived credentials instead of stored access keys.
resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}
