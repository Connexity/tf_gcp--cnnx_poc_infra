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
