resource "google_logging_metric" "logging-metric_custom-role-monitoring" {
  name   = "custom-role-monitoring/metric"
  description = "Required for NIST 800-53 R5, ISO 27001 2022, NIST CSF 1.0 and others."
  filter = "resource.type=\"iam_role\" AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "alert_policy-custom-role-monitoring" {
  display_name = "A Custom Role has been created, edited or deleted"
  combiner     = "OR"
  conditions {
    display_name = "A Custom Role has been created, edited or deleted"
    condition_threshold {
      filter     = "resource.type = \"global\" AND metric.type = \"logging.googleapis.com/user/custom-role-monitoring/metric\""
      duration   = "180s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "1200s"
        per_series_aligner = "ALIGN_DELTA"
      }
      trigger {
        count   = "1"
        percent = "0"
      }
    }
  }
  notification_channels = ["projects/cnnx-poc-infra/notificationChannels/4565085722272089401"]
}
