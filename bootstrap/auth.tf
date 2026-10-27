# Bootstrap: one-time resources the CI pipeline depends on.
# Applied manually from a workstation with local state. Everything else in
# the project is deployed by GitHub Actions.

terraform {
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