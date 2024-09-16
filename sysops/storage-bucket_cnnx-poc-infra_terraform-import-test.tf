resource "google_storage_bucket" "bucket--cnnx-poc-infra_terraform-import-test" {
  name          = "cnnx-poc-infra_terraform-import-test"
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  labels = {
    "owner" = "sysops"
    "app" = "test"
  }
}

data "google_iam_policy" "cnnx-poc-infra_terraform-import-test_bucket_iam_policy" {
  binding {
    role = "roles/storage.legacyBucketReader"
    members = [ "projectViewer:${var.gcp_project}" ]
  }
  binding {
    role = "roles/storage.legacyObjectOwner"
    members = [ "projectEditor:${var.gcp_project}", "projectOwner:${var.gcp_project}" ]
  }
  binding {
    role = "roles/storage.legacyObjectReader"
    members = [  "projectViewer:${var.gcp_project}" ]
  }
  binding {
    role = "roles/storage.legacyBucketOwner"
    members = [ "projectEditor:${var.gcp_project}", "projectOwner:${var.gcp_project}" ]
  }
}

resource "google_storage_bucket_iam_policy" "cnnx-poc-infra_terraform-import-test_policy" {
  bucket = google_storage_bucket.bucket--cnnx-poc-infra_terraform-import-test.name
  policy_data = data.google_iam_policy.cnnx-poc-infra_terraform-import-test_bucket_iam_policy.policy_data
}
