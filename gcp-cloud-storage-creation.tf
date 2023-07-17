provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-east2"
}
resource "google_storage_bucket" "my-frist-bucket_wave3" {
 name          = "my-frist-bucket_wave3"
 location      = "US"
 storage_class = "STANDARD"
  lifecycle {
    prevent_destroy = true
  }
}
