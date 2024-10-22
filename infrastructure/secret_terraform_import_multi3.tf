resource "google_secret_manager_secret" "secret--terraform_import_multi3" {
  secret_id = "terraform_import_multi3"
  labels = {
    owner = "infrastructure"
    app = "test"
  }
  replication {
    auto {}
  }
}
