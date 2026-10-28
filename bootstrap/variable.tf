variable "region" {
  description = "AWS region; must match the main Terraform config"
  type        = string
  default     = "us-east-1"
}

variable "github_repo" {
  description = "GitHub repository allowed to assume the CI role, as owner/name"
  type        = string
  default     = "FaboCloudsurf/TC3_IaC_terraform_ansible"

}
