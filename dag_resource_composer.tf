resource "google_storage_bucket_object" "dag_object" {
  name   = "dags/hello_world_dag.py"
  bucket = "gs://asia-south2-composer-enviro-71078552-bucket/dags"
  source = "hello_world_dag.py" 
  # Ensure you replace the above with your local path
}
