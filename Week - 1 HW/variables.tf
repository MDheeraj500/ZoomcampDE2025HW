variable "credentials" {
  description = "Credentials to Dheeru Bhai GCP service account - terraform_serviceaccount"
  default     = "./keys/my-creds.json"
}

variable "project" {
  description = "Project ID"
  default     = "terraform-testing-445804"
}

variable "region" {
  description = "Region of the project"
  default     = "us-central1"
}

variable "location" {
  description = "Location of the project"
  default     = "US"
}

variable "bq_dataset_id" {
  description = "Big Query dataset id"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "GCS bucket name"
  default     = "terraform-testing-445804-terraform-demo"
}




