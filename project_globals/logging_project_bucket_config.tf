resource "google_logging_project_bucket_config" "cnnx-poc-infra--google_logging_project_bucket_config" {
    project    = "${var.gcp_project}"
    location  = "global"
    enable_analytics = true
    retention_days = 400
    bucket_id = "_Default"
}
