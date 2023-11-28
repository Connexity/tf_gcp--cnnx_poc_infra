resource "google_service_account_iam_binding" "SA_gce-sa--vuln-patching-notifications--iam_binding" {
  service_account_id = google_service_account.SA_gce-sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:vuln-patching-notifications@cnnx-infra-admin.iam.gserviceaccount.com",
  ]
}
