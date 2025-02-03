terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.14.1"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = file(var.credentials)
}



resource "google_storage_bucket" "terraform_demo_bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }

}


resource "google_bigquery_dataset" "terraform_demo_dataset" {
  dataset_id                 = var.bq_dataset_id
  delete_contents_on_destroy = true

}














