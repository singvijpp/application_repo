provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south2"
  zone        ="asia-south2-a"
}
terraform {
  backend "gcs" {
    bucket = "gcp_state_cicd"
    prefix = "terraform/state"
  }
}
