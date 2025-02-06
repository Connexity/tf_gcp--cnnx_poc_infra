# Declare Variables
variable "gce_instance_backups" {
  description = "List of GCE instance backups to associate with backup plan associations."
  type        = map(list(string))
  default     = {
    gitlab-stage001 = [ "cnnx-poc-daily-backups", "us-central1-a" ],
    rundeck-stage = [ "cnnx-poc-daily-backups", "us-central1-a" ]
  }
}

# Create the Google Vault
resource "google_backup_dr_backup_vault" "cnnx_poc-backup-vault" {
  provider                                   = google-beta
  location                                   = "us-central1"
  project                                    = "${var.gcp_project}"
  backup_vault_id                            = "cnnx-poc-backup-vault"
  description                                = "This vault is created using Terraform."
  backup_minimum_enforced_retention_duration = "345600s"
  force_update                               = "true"
  ignore_inactive_datasources                = "true"
  allow_missing                              = "true"
}

# Create Backup Plan.
resource "google_backup_dr_backup_plan" "cnnx-poc-daily" {
  provider       = google-beta
  location       = "us-central1"
  project        = "${var.gcp_project}"
  backup_plan_id = "cnnx-poc-daily-backups"
  resource_type  = "compute.googleapis.com/Instance"
  backup_vault   = google_backup_dr_backup_vault.cnnx_poc-backup-vault.name

  backup_rules {
    rule_id               = "rule-1"
    backup_retention_days = 5

    standard_schedule {
      recurrence_type  = "DAILY"
      time_zone        = "UTC"

      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 8
      }
    }
  }
}

# Create a backup plan association.
resource "google_backup_dr_backup_plan_association" "instance_backup-plan" {
  for_each = var.gce_instance_backups
  provider                   = google-beta
  location                   = "us-central1"
  project                    = "${var.gcp_project}"
  backup_plan_association_id = each.value[0]
  resource                   = "projects/${var.gcp_project}/zones/${each.value[1]}/instances/${each.key}"
  resource_type              = "compute.googleapis.com/Instance"
  backup_plan                = google_backup_dr_backup_plan.cnnx-poc-daily.name
}
