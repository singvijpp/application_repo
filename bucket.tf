resource "google_storage_bucket" "demo" {
  name          = "Demobucket"
  location      = "asia-south2"
  force_destroy = true

  uniform_bucket_level_access = true
}
