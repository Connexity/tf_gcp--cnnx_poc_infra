resource "google_storage_bucket" "bucket--gcs-fuse-test_cnnx-poc-infra" {
  name          = "gcs-fuse-test_cnnx-poc-infra"
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 0
  }
  labels = {
    "owner" = "sysops"
    "app" = "gcsfuse"
  }
}

data "google_iam_policy" "gcs-fuse-test_cnnx-poc-infra_bucket_iam_policy" {
  binding {
    role = "roles/storage.objectAdmin"
    members = [ "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com" ]
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = [ "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com", "projectViewer:${var.gcp_project}" ]
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

resource "google_storage_bucket_iam_policy" "gcs-fuse-test_cnnx-poc-infra_policy" {
  bucket = google_storage_bucket.bucket--gcs-fuse-test_cnnx-poc-infra.name
  policy_data = data.google_iam_policy.gcs-fuse-test_cnnx-poc-infra_bucket_iam_policy.policy_data
}
