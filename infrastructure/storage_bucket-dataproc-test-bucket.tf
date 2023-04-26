resource "google_storage_bucket" "bucket--dataproc-test-bucket" {
  name          = "dataproc-test-bucket"
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  labels = {
    "owner" = "sysops"
    "app" = "dataproc-test"
  }
}

data "google_iam_policy" "dataproc-test-bucket_bucket_iam_policy" {
  binding {
    role = "roles/storage.objectCreator"
    members = [ "serviceAccount:dataproc-test@cnnx-poc-infra.iam.gserviceaccount.com" ]
  }
  binding {
    role = "roles/storage.objectViewer"
    members = [ "serviceAccount:dataproc-test@cnnx-poc-infra.iam.gserviceaccount.com" ]
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = [ "serviceAccount:dataproc-test@cnnx-poc-infra.iam.gserviceaccount.com", "projectViewer:${var.gcp_project}" ]
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
  binding {
    role = "roles/storage.legacyBucketReader"
    members = [ "projectViewer:${var.gcp_project}" ]
  }
}

resource "google_storage_bucket_iam_policy" "dataproc-test-bucket_policy" {
  bucket = google_storage_bucket.bucket--dataproc-test-bucket.name
  policy_data = data.google_iam_policy.dataproc-test-bucket_bucket_iam_policy.policy_data
}
