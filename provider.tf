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
    bucket = var.backend_bucket
    prefix = "terraform/state"
  }
}
