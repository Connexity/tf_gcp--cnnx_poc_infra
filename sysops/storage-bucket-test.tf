resource "google_storage_bucket" "bucket--test_cnnx-stage-inventory" {
  name          = "test_cnnx-stage-inventory"
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  labels = {
    "owner" = "sysops"
    "app" = "test"
  }

  lifecycle_rule {
    condition {
      age = 10
      matches_suffix = [".gz", ".pb", ".jar"]
      with_state = "ANY"
    }
    action {
      type = "Delete"
    }
  }
}

data "google_iam_policy" "test_cnnx-stage-inventory_bucket_iam_policy" {
  binding {
    role = "roles/storage.objectAdmin"
    members = [ "group:cnnx-syseng@skimlinks.co.uk" ]
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = [ "group:cnnx-syseng@skimlinks.co.uk", "projectViewer:${var.gcp_project}" ]
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
