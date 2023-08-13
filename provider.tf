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
    bucket = "terraform_bucket_cicd_2"
    prefix = "terraform/state"
  }
}
