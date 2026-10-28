variable "aws_region" {
  type    = string
  default = "us-east-1"

}

variable "TC3_instance" {
  type    = string
  default = "t2.micro"

}

variable "TC3_instance_type" {
  type    = string
  default = "t2.micro"

}

variable "key_name" {
  type    = string
  default = "1_percent_keypair517"

}

variable "environment" {
  type    = string
  default = "production"
}

variable "project_name" {
  type    = string
  default = "TC3"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "github_repo" {
  description = "GitHub repository allowed to assume the CI role, as owner/name"
  type        = string
  default     = "FaboCloudsurf/TC3_IaC_terraform_ansible"
}