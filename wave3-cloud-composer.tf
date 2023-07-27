resource "google_project_service" "composer_api" {
  provider = google-beta
  project = "db-cicdpipeline-wave3"
  service = "composer.googleapis.com"
  // Disabling Cloud Composer API might irreversibly break all other
  // environments in your project.
  disable_on_destroy = false
}

resource "google_service_account" "custom_service_account" {
  provider = google-beta
  account_id   = "custom-service-account"
  display_name = "Example Custom Service Account"
}

resource "google_project_iam_member" "custom_service_account" {
  provider = google-beta
  project  = "db-cicdpipeline-wave3"
  member   = format("serviceAccount:%s", google_service_account.custom_service_account.email)
  // Role for Public IP environments
  for_each = toset([
    "roles/composer.worker",
    "roles/composer.ServiceAgentV2Ext",
  ])
  role = each.key
}

resource "google_project_iam_member" "custom_code" {
  project = "db-cicdpipeline-wave3"
  member   = "service-36949417800@cloudcomposer-accounts.iam.gserviceaccount.com"
  // Role for Public IP environments
  role =   "roles/composer.ServiceAgentV2Ext",
 }


resource "google_composer_environment" "example_environment" {
  provider = google-beta
  name = "wave3-cicd-composer-env"

  config {

    node_config {
      service_account = google_service_account.custom_service_account.email
    }

  }
}
