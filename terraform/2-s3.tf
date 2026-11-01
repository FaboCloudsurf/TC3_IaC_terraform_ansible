resource "aws_s3_bucket" "TC3_bucket" {
  bucket_prefix = "tc3-bucket"

  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = var.environment
  }
}

# ---------------------------------------------------------------------------
# Web page stored in the bucket under site/.
# The instance downloads it during Ansible configuration using its IAM role,
# which has read access to site/* only.
# ---------------------------------------------------------------------------
resource "aws_s3_object" "TC3_index" {
  bucket       = aws_s3_bucket.TC3_bucket.id
  key          = "site/index.html"
  source       = "${path.module}/../site/index.html" # path relative to terraform/
  content_type = "text/html"

  # Re-upload whenever the file's contents change
  etag = filemd5("${path.module}/../site/index.html")
}