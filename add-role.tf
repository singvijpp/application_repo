resource "google_project_iam_member" "project" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/editor"
  members = "service_account: ${{ secrets.garage_service_account }}"
}
