resource "google_service_account_iam_binding" "SA_gce-sa--iam_serviceAccountUser--iam_binding" {
  service_account_id = google_service_account.SA_gce-sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:cnnx-serviceaccount-gce-oslogin@skimlinks.co.uk",
  ]
}
