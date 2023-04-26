resource "google_service_account" "SA_gce-sa" {
  account_id   = "gce-sa"
  description  = "GCE service account"
  disabled     = "false"
  display_name = "gce-sa"
}

resource "google_service_account" "SA_dataproc-test" {
  account_id   = "dataproc-test"
  description  = ""
  disabled     = "false"
  display_name = "dataproc-test"
}

resource "google_service_account" "SA_dataproc" {
  account_id   = "dataproc"
  description  = ""
  disabled     = "false"
  display_name = "dataproc-test"
}
