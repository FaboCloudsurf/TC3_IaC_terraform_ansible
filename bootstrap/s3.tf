# Remote state bucket.
# Holds terraform.tfstate for the main config so the pipeline and local runs
# share one source of truth.

resource "aws_s3_bucket" "tf_state" {
  bucket_prefix = "tc3-tfstate-"

  lifecycle {
    prevent_destroy = true # losing state orphans every resource it tracks
  }
}

# Versioning keeps previous state files, so a bad write can be rolled back.
resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# State can contain sensitive values; block every form of public access.
resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

