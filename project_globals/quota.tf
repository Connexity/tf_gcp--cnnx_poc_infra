resource "google_service_usage_consumer_quota_override" "bq_usage_per_day" {
  provider = google-beta
  project = "${var.gcp_project}"
  service = "bigquery.googleapis.com"
  metric = urlencode("bigquery.googleapis.com/quota/query/usage")
  limit = urlencode("/d/project/user")
  override_value = "5242880"
  force = true
}
