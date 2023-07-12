provider "google" {
  project     = var.project
  region      = var.region
}
resource "google_storage_bucket" "test-bucket-for-state" {
 name          = "nikhils-bucket"
 location      = "US"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}
