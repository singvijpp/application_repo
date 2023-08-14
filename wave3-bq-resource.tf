
resource "google_bigquery_dataset" "terraform_state_dataset" {
  dataset_id  = "terraform_state_dataset"
  description = "Dataset to store Terraform state data"
  location    = "asia-south2"  # Change to your preferred location

  default_table_expiration_ms = 3600000

  access {
    role          = "OWNER"
    user_by_email = google_service_account.composer_env_sa.email
  }
}

resource "google_bigquery_table" "terraform_state_table" {
  dataset_id = google_bigquery_dataset.terraform_state_dataset.dataset_id
  table_id   = "terraform_resources"

  time_partitioning {
    type = "DAY"
  }

  schema = <<EOF
[
  {
    "name": "type",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "name",
    "type": "STRING",
    "mode": "REQUIRED"
  }
]
EOF
}

resource "google_bigquery_dataset_iam_member" "dataset_iam_member" {
  dataset_id = google_bigquery_dataset.terraform_state_dataset.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:vijay.psingh2@tcs.com"
}

resource "google_bigquery_dataset_iam_member" "dataset_edit_comoser_member" {
  dataset_id = google_bigquery_dataset.terraform_state_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.composer_env_sa.email}"
}
resource "google_bigquery_dataset_iam_member" "dataset_view_comoser_member" {
  dataset_id = google_bigquery_dataset.terraform_state_dataset.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "serviceAccount:${google_service_account.composer_env_sa.email}"
}