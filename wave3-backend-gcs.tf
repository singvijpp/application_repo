terraform {
  backend "gcs" {
    bucket  = "wave3-cicd-bucket"
    prefix  = "terraform/state"
  }
}