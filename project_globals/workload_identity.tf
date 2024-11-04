#resource "google_service_account_iam_binding" "import-tests-wl-binding" {
#  service_account_id = google_service_account.SA_import-tests.name
#  role = "roles/iam.workloadIdentityUser"
#  members = [
#    "serviceAccount:cnnx-infra-k8s.svc.id.goog[composer-system/custom-metrics-stackdriver-adapter]",
#    "serviceAccount:cnnx-infra-k8s.svc.id.goog[composer-system/default]",
#  ]
#}
