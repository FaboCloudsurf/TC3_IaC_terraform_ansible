  # Bootstrap: one-time resources the CI pipeline depends on
  # (state bucket, GitHub OIDC provider, CI role).
  # Applied manually from a workstation. First apply used local state;
  # state was then migrated into the bucket it created.
terraform {
  # Bootstrap state moved into the bucket it created, under its own key.
  # Initial apply used local state because the bucket didn't exist yet.
  backend "s3" {
    bucket       = "tc3-tfstate-5c7925385f8110c640fd30ad87"
    key          = "bootstrap/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # match the version used in terraform/0-auth.tf
    }
  }
}

provider "aws" {
  region = var.region
}