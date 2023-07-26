 provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south2"
  zone        ="asia-south2-a"
}
 resource "google_storage_bucket" "static" {
  name          = "gcp_state_cicd"
  location      = "asia-south2"
}
