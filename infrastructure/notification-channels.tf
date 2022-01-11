resource "google_monitoring_notification_channel" "sysops_email" {
  display_name = "SysOps@connexity.com"
  type         = "email"
  labels = {
    email_address = "SysOps@connexity.com"
  }
}

