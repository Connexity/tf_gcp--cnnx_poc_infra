### secret_group_validation_gitlab_token ####

resource "google_secret_manager_secret" "secret_group_validation_gitlab_token" {
  secret_id = "group_validation_gitlab_token" 

  labels = {
    owner = "syseng"
    app = "groupsvalidation"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_binding" "group_validation_gitlab_token_secret_accessor_binding" {
  project = "${var.gcp_project}"
  secret_id = google_secret_manager_secret.secret_group_validation_gitlab_token.secret_id
  role = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
  ]
}
