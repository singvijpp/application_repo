provider "google" {
 project = var.project_id
 region  = var.region
 credentials = "${file("db-cicdpipeline-wave3-03bfb10085a9.json")}"
}

terraform {
  backend "gcs" {
    bucket = "cicd-action"
    prefix = "terraform/state"
  }
}
