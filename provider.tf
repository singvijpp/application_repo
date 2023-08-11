provider "google" {
 project = var.project_id
 region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "db-cicd-wave3"
    prefix = "terraform/state"
  }
}
