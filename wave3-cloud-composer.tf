resource "google_project_service" "composer_api" {
  provider = google-beta
  project = "db-cicdpipeline-wave3"
  service = "composer.googleapis.com"
  // Disabling Cloud Composer API might irreversibly break all other
  // environments in your project.
  disable_on_destroy = false
}
resource "google_project_iam_member" "custom_code" {
  project = "db-cicdpipeline-wave3"
  member   = "serviceAccount:service-36949417800@cloudcomposer-accounts.iam.gserviceaccount.com"
  // Role for Public IP environments
  role =   "roles/composer.ServiceAgentV2Ext"
 }

resource "google_project_iam_member" "worker_code" {
  project = "db-cicdpipeline-wave3"
  member   = "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com"
  // Role for Public IP environments
  role =   "roles/composer.worker"
 }

resource "google_composer_environment" "example_environment" {
  provider = google-beta
  name = "wave3-cicd-composer-env"

  config {

    node_config {
      service_account = "service-36949417800@cloudcomposer-accounts.iam.gserviceaccount.com"
    }

  }
}
