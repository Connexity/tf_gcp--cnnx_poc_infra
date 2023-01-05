resource "google_storage_bucket" "sysops-test_cnnx-poc-infra" {
  name          = "sysops-test_cnnx-poc-infra"
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  labels = { 
    "owner" = "sysops"
    "app" = "test"
  }
}

