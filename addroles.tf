resource "google_project_iam_member" "associate" {
  project = "db-cicdpipeline-wave3"
  role     = "roles/iap.tunnelResourceAccessor"
  member   = "user:pm.deshpande@tcs.com"
}
