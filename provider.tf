terraform {
  backend "gcs" {
    bucket = "gcp_state_cicd"
    prefix = "terraform/state"
  }
}
