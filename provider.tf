provider "google" {
 project = var.project_id
 region  = var.region
}

provider "google-beta" {
  project = "db-cicdpipeline-wave3"
  region  = "asia-south2"
}

terraform {
  backend "gcs" {
    bucket = "cicd-action"
    prefix = "terraform/state"
  }
}
