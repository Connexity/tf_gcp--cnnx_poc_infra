resource "google_service_account" "SA_gce-sa" {
  account_id   = "gce-sa"
  description  = "GCE service account"
  disabled     = "false"
  display_name = "gce-sa"
}

resource "google_service_account" "SA_migration-manager" {
  account_id   = "migration-manager"
  description  = "Migration Mmanager SA"
  disabled     = "false"
  display_name = "migration-manager"
}

resource "google_service_account" "SA_migration-cloud-extension" {
  account_id   = "migration-cloud-extension"
  description  = "Migration Cloud Extention SA"
  disabled     = "false"
  display_name = "migration-cloud-extension"
}

