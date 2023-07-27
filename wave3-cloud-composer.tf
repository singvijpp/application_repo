resource "google_service_account" "composer_env_sa" {
  project      = data.google_project.project.project_id
  account_id   = "composer-worker-sa"
  display_name = "Test Service Account for Composer Environment deployment "
}

resource "google_project_service_identity" "composer_sa" {
  provider = google-beta
  project  = data.google_project.project.project_id
  service  = "composer.googleapis.com"
}

resource "google_project_iam_member" "composer_worker" {
  project = data.google_project.project.project_id
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_env_sa.email}"
}

resource "google_service_account_iam_member" "custom_service_account" {
  provider           = google-beta
  service_account_id = google_service_account.composer_env_sa.id
  role               = "roles/composer.ServiceAgentV2Ext"
  member             = "serviceAccount:${google_project_service_identity.composer_sa.email}"
}

resource "google_composer_environment" "example_environment" {
  provider = google-beta
  name = "wave3-cicd-composer-env"

  config {

    software_config {
      image_version = "composer-2-airflow-2"
    }
    workloads_config {
      scheduler {
        cpu        = 0.5
        memory_gb  = 1.875
        storage_gb = 1
        count      = 1
      }
      web_server {
        cpu        = 0.5
        memory_gb  = 1.875
        storage_gb = 1
      }
      worker {
        cpu        = 0.5
        memory_gb  = 1.875
        storage_gb = 1
        min_count  = 1
        max_count  = 3
      }
    }
    environment_size = "ENVIRONMENT_SIZE_SMALL"

    node_config {
      service_account = "service-36949417800@cloudcomposer-accounts.iam.gserviceaccount.com"
	  service_account = google_service_account.composer_env_sa.email
    }

  }
}
