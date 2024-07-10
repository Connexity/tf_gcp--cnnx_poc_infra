resource "google_artifact_registry_repository" "cnnx-poc-docker" {
  project = var.gcp_project
  location = "us-central1"
  repository_id = "cnnx-poc-docker"
  format = "DOCKER"
  description = "Docker image repo for poc"
  cleanup_policy_dry_run = true
  cleanup_policies {
    id     = "delete-prerelease"
    action = "DELETE"
    condition {
      tag_state    = "ANY"
      older_than   = "60d"
    }
  }
  cleanup_policies {
    id     = "keep-tagged-release"
    action = "KEEP"
    condition {
      tag_state             = "TAGGED"
      tag_prefixes          = ["release"]
    }
  }
  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count            = 3
    }
  }
}
