resource "google_secret_manager_secret" "secret--terraform_import_test" {
  secret_id = "terraform_import_test"
  labels = {
    owner = "sysops"
    app = "terraform-test"
  }
  replication {
    auto {}
  }
}
