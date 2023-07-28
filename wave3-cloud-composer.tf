#   Usage:
#       1. Select or create a new project that you will use to create the resources
#       2. Set up your environment and apply the configuration using basic Terraform commands: https://cloud.google.com/docs/terraform/basic-commands
#
#   The script provisions the following resources in the project:
#  	- Creates a VPC network and a subnetwork
#	- Creates a Cloud Composer environment
#	- Creates a Composer Service Agent account
#	- Grants the Cloud Composer v2 API Service Agent Extension role and the Composer Worker role to the Composer Service Agent account
#	- Creates a new Cloud Storage bucket
#	- Creates a new Cloud Function and deploys the function source code from the pubsub_function.zip file to the Cloud Storage bucket
#	- Uploads the example DAG source code from the specified file into the Cloud Composer bucket

#



resource "google_project_service" "composer" {
  project = "db-cicdpipeline-wave3"
  service = "composer.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
  disable_on_destroy         = false
}

###############################
#                             #
# Create Composer environment #
#                             #
###############################
resource "google_composer_environment" "new_composer_env" {
  name    = "composer-environment"
  region  = "asia-south2"
  project = "db-cicdpipeline-wave3"
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
      service_account = google_service_account.composer_env_sa.email
    }
  }
}


#########################
#                       #
# Creates IAM resources #
#                       #
#########################
# Comment this section to use an existing service account
resource "google_service_account" "composer_env_sa" {
  project      = "db-cicdpipeline-wave3"
  account_id   = "cicd-wave3-serviceaccot"
  display_name = "Test Service Account for Composer Environment deployment "
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