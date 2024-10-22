resource "google_secret_manager_secret" "secret--terraform_import_multi2" {
  secret_id = "terraform_import_multi2"
  labels = {
    owner = "infrastructure"
    app = "test"
  }
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_binding" "terraform_import_multi2_secretAccessor_binding" {
  project = "${var.gcp_project}"
  secret_id = google_secret_manager_secret.secret--terraform_import_multi2.secret_id
  role = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:vuln-patching-notifications@cnnx-infra-admin.iam.gserviceaccount.com"
  ]
}
