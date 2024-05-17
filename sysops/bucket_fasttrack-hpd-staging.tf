resource "google_storage_bucket" "fasttrack-hpd-staging-cnnx-poc-infra" {
  name          = "fasttrack-hpd-staging-cnnx-poc-infra"
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  labels = {
    "owner" = "fastrack"
    "app" = "marketplace"
  }
}

data "google_iam_policy" "fasttrack-hpd-staging-cnnx-poc-infra_policy" {
  binding {
    role = "roles/storage.objectAdmin"
    members = [ "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com" ]
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = [ "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com", "projectViewer:${var.gcp_project}" ]
  }
  binding {
    role = "roles/storage.legacyObjectOwner"
    members = [ "projectEditor:${var.gcp_project}", "projectOwner:${var.gcp_project}" ]
  }
  binding {
    role = "roles/storage.legacyObjectReader"
    members = [ "projectViewer:${var.gcp_project}" ]
  }
  binding {
    role = "roles/storage.legacyBucketOwner"
    members = [ "projectEditor:${var.gcp_project}", "projectOwner:${var.gcp_project}" ]
  }
}

resource "google_storage_bucket_iam_policy" "fasttrack-hpd-staging-cnnx-poc-infra_iam_policy" {
  bucket = google_storage_bucket.fasttrack-hpd-staging-cnnx-poc-infra.name
  policy_data = data.google_iam_policy.fasttrack-hpd-staging-cnnx-poc-infra_policy.policy_data
}

