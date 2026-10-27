resource "aws_s3_bucket" "TC3_bucket" {
  bucket_prefix = "tc3-bucket"

  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = var.environment
  }
}