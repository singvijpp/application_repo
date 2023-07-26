resource "google_storage_bucket" "static" {
  name          = "gcp_wave3_cicd"
  location      = "asia-south2"
  force_destroy = true
} 
