variable "project_id" {
  type        = string
  description = "The Google Cloud Project Id"
}

variable "region" {
  type    = string
  default = "asia-south2"
}

variable "backend_bucket" {
  type = string
  default = "cicd-action"
  }