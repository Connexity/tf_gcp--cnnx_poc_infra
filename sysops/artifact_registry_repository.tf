resource "google_artifact_registry_repository" "cnnx-apt-focal-poc_cnnx-poc-infra_artifact_registry" {
  location      = "us-central1"
  repository_id = "cnnx-apt-focal-poc"
  description   = "Repository for cnnx custom Ubuntu 20.04 (focal) packages. Test repo."
  format        = "APT"
  project       = "${var.gcp_project}"
  labels = {
    "owner" = "sysops"
    "app" = "apt-repository"
  }
}

data "google_iam_policy" "cnnx-apt-focal-poc_iam_binding_policy" {
  binding {
    role = "roles/artifactregistry.reader"
    members = [
      "serviceAccount:logdump@cnnx-stage-tracking.iam.gserviceaccount.com",
    ]
  }
}

resource "google_artifact_registry_repository_iam_policy" "cnnx-apt-focal-poc_iam_policy" {
  project = google_artifact_registry_repository.cnnx-apt-focal-poc_cnnx-poc-infra_artifact_registry.project
  location = google_artifact_registry_repository.cnnx-apt-focal-poc_cnnx-poc-infra_artifact_registry.location
  repository = google_artifact_registry_repository.cnnx-apt-focal-poc_cnnx-poc-infra_artifact_registry.name
  policy_data = data.google_iam_policy.cnnx-apt-focal-poc_iam_binding_policy.policy_data
}
