terraform {
    backend "s3" {
    bucket       = "tc3-tfstate-5c7925385f8110c640fd30ad87"
    key          = "tc3/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}


