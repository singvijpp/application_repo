/* provider "google" {
 project = var.project_id
 region  = var.region
}
*/
terraform {
  backend "gcs" {
    bucket = "gcp_wave3_cicd"
    prefix = "terraform/state"
  }
}
