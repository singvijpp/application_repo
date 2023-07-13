resource "google_storage_bucket" "bucket" {
  name          = "terraform_bucket_cicd"
  location      = "asia-south2"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle {
    rule {
      action {
        type = "Delete"
      }
      condition {
        age = 30
      }
    }
  }

  logging {
    log_bucket = "cicd-action"
    log_object_prefix = "logs/"
  }

  website {
    main_page_suffix = "index.html"
    not_found_page = "404.html"
  }
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
