provider "google" {
  project     = var.project
  region      = var.region
}
resource "google_storage_bucket" "test-bucket-for-state" {
 name          = "db-cicd-wave3"
 location      = "US"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}
terraform {
  backend "gcs" {
    bucket  = "db-cicd-wave3"
    prefix  = "terraform/state"
  }
}