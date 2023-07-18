resource "google_project_iam_member" "project" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/editor"
  member  = "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com"
}
