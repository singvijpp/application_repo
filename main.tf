provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-east2"
}
resource "google_storage_bucket" "test-bucket-for-state" {
 name          = "db-cicd-wave3"
 location      = "US"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}