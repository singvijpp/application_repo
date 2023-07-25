/*resource "google_project_iam_member" "project" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/editor"
  member  = "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com"
}*/
resource "google_project_iam_member" "member" {
  project = "db-cicdpipeline-wave3"

  zone     = "asia-south2-a"
  instance = "gcpwave3-linux-vm"
  role     = "roles/iap.tunnelResourceAccessor"
  member   = "user:swapnil.gargade@tcs.com"
}
