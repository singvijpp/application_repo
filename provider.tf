provider "google" {
 project = var.project_id
 region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "cicd-py"
    prefix = "terraform/state"
  }
}
