provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-east2"
}
resource "google_storage_bucket" "test-bucket-for-state" {
 name          = "my-frist-bucket_wave3"
 location      = "US"
 force_destroy = true

 public_access_prevention = "enforced"
}
