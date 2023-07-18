resource "google_storage_bucket" "bucket" {
  name          = "mybucket1"
  location      = "asia-south2"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}
