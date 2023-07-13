provider "google" {
 project = "db-cicdpipeline-wave3"
 region = "asia-south2-2"
 credentials = "${file("db-cicdpipeline-wave3-03bfb10085a9.json")}"
}

terraform {
  backend "gcs" {
    bucket = "cicd-action"
    prefix = "terraform/state"
  }
}
