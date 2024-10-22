resource "google_secret_manager_secret" "secret--terraform_import_multi1" {
  secret_id = "terraform_import_multi1"
  labels = {
    owner = "infrastructure"
    app = "test"
  }
  replication {
    auto {}
  }
}
