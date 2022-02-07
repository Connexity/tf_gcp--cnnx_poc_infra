resource "google_storage_bucket" "sysops-test_cnnx-poc-infra" {
  name          = "sysops-test_cnnx-poc-infra"
  location      = "us-central1"
  force_destroy = true
  storage_class = "standard"
  uniform_bucket_level_access = true
  labels = { 
    "owner" = "sysops"
    "app" = "test"
  }
}

data "google_iam_policy" "sysops-objectadmin_sysops-test_cnnx-poc-infra" {
  binding {
    role = "roles/storage.objectAdmin"
    members = [
      "user:pharrison@connexity.com",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy" {
  bucket = google_storage_bucket.sysops-test_cnnx-poc-infra.name
  policy_data = data.google_iam_policy.sysops-objectadmin_sysops-test_cnnx-poc-infra.policy_data
}
