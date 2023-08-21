resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "db-cicd-wave3"
  role = "roles/storage.admin"
  members = [
    "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com",
  ]
}
