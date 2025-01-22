resource "google_logging_metric" "logging-metric_custom-role-monitoring" {
  name   = "custom-role-monitoring/metric"
  description = "Required for NIST 800-53 R5, ISO 27001 2022, NIST CSF 1.0 and others."
  filter = "resource.type=\"iam_role\" AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
