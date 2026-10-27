data "aws_iam_policy_document" "github_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    # Token must be issued for AWS STS
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Token must come from this repo: pushes to main, or pull requests
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_repo}:ref:refs/heads/main",
        "repo:${var.github_repo}:pull_request",
      ]
    }
  }
}

# Role assumed by the pipeline to run Terraform and Ansible.
resource "aws_iam_role" "github_actions" {
  name               = "tc3-github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_trust.json
}

# Broad permissions: the pipeline creates EC2, S3, and IAM resources.
# Access is constrained by the trust policy above, not by this policy.
resource "aws_iam_role_policy_attachment" "github_actions_admin" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
