variable "bucket_names" {
  description = "The list of existing bucket names to manage with Terraform"
  type        = list(string)
  default     = ["asia-south2-composer-enviro-0b678a75-bucket","asia-south2-composer-enviro-0df48071-bucket","asia-south2-composer-enviro-23cdaeaf-bucket",
"asia-south2-composer-enviro-35423157-bucket","asia-south2-composer-enviro-4cf71d24-bucket","asia-south2-composer-enviro-4f9b397a-bucket",
"asia-south2-composer-enviro-61329c25-bucket","asia-south2-composer-enviro-6b63a0fd-bucket","asia-south2-composer-enviro-71078552-bucket",
"asia-south2-composer-enviro-72b9a185-bucket","asia-south2-composer-enviro-952b89b0-bucket","asia-south2-composer-enviro-98a85dbd-bucket",
"asia-south2-composer-enviro-a1544aa9-bucket","asia-south2-composer-enviro-b44bf1e1-bucket","asia-south2-composer-enviro-e1bceaa3-bucket",
"asia-south2-composer-enviro-e68fb945-bucket"]  # Replace with your bucket names
}

resource "google_storage_bucket" "managed_buckets" {
  for_each = toset(var.bucket_names)

  name          = each.value
  force_destroy = true  # Delete even if bucket has content
}
