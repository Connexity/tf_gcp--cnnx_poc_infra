resource "google_service_account" "SA_gce-sa" {
  account_id   = "gce-sa"
  description  = "GCE service account"
  disabled     = "false"
  display_name = "gce-sa"
}

resource "google_service_account" "SA_dataproc" {
  account_id   = "dataproc"
  description  = ""
  disabled     = "false"
  display_name = "dataproc-test"
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

resource "google_service_account" "SA_fasttrack-hdp" {
  account_id   = "fasttrack-hdp"
  description  = "fasttrack-hdp SA"
  disabled     = "false"
  display_name = "fasttrack-hdp"
}

