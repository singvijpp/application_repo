resource "google_project_service" "composer_env_sa" {
  provider = google-beta
  project = "db-cicdpipeline-wave3"
  service = "composer.googleapis.com"
  // Disabling Cloud Composer API might irreversibly break all other
  // environments in your project.
  disable_on_destroy = false
}
resource "google_project_service_identity" "composer_sa" {
  provider = google-beta
  project  = "db-cicdpipeline-wave3"
  service  = "composer.googleapis.com"
}

resource "google_project_iam_member" "composer_worker" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_env_sa.email}"
}

resource "google_service_account_iam_member" "custom_service_account" {
  provider           = google-beta
  service_account_id = google_service_account.composer_env_sa.id
  role               = "roles/composer.ServiceAgentV2Ext"
  member             = "serviceAccount:${google_project_service_identity.composer_sa.email}"
}

resource "google_composer_environment" "composer_environment" {
  provider = google-beta
  name = "wave3-cicd-composer-env"

  config {

    node_config {
      service_account = google_service_account.composer_env_sa.email
    }

  }
}
