# Trust policy: WHO may assume this role.
# Only the EC2 service can assume it. This says nothing about what the role
# can do. Permissions are defined separately below.
data "aws_iam_policy_document" "TC3_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]   # "assume role" = temporarily become this identity

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


# IAM role the web server runs as.
# Gives the instance AWS credentials without storing access keys on the box.
# Credentials are temporary and rotated automatically through the instance
# metadata service.
resource "aws_iam_role" "TC3_role" {
  name               = "${var.project_name}-role"
  assume_role_policy = data.aws_iam_policy_document.TC3_assume_role.json

  tags = {
    Name        = "${var.project_name}-role"
    Environment = var.environment
  }
}

# The wrapper EC2 requires.
# An EC2 instance can't be handed a role directly — it only accepts an instance
# profile, which is a container holding exactly one role.
resource "aws_iam_instance_profile" "TC3_instance_profile" {
  name = "${var.project_name}-profile"
  role = aws_iam_role.TC3_role.name      # takes the role's name, not its ARN
}



# Permissions policy: WHAT the role may do.
# Least privilege: read-only access to the site/ prefix of this project's
# bucket. No write, no delete, and no access to any other bucket.
# The bucket stores the web content (index.html). During configuration,
# Ansible has the instance download it from S3 using this role.
data "aws_iam_policy_document" "TC3_policy" {

  statement {
    sid       = "ReadSiteContent"
    effect    = "Allow"
    actions   = ["s3:GetObject"]                                 # download objects only
    resources = ["${aws_s3_bucket.TC3_bucket.arn}/site/*"]   # objects under site/ only

  }


  statement {
    sid       = "ListSitePrefix"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]                                 # bucket-level action
    resources = [aws_s3_bucket.TC3_bucket.arn]   

        # Restrict listing to the site/ prefix. Without ListBucket, a missing
    # object returns 403 Access Denied instead of 404 Not Found, which makes
    # debugging misleading.
    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["site/*"]
    }
  }
  
}

# Attach the permissions to the role.
# Inline policy: it exists only on this role and is deleted with it.
resource "aws_iam_role_policy" "TC3_role_policy" {
  name   = "${var.project_name}-s3-read"
  role   = aws_iam_role.TC3_role.id
  policy = data.aws_iam_policy_document.TC3_policy.json
}


  