resource "google_project_iam_custom_role" "custom_role-cnnx-prod-merchant--bigtable_backup" {
  project     = "${var.gcp_project}"
  role_id     = "bigtable_backup"
  title       = "bigtable_backup"
  description = "Role required for bigtable backup."
  stage       = "GA"
  permissions = ["bigtable.tables.readRows",
                 "bigtable.backups.create",
                 "bigtable.backups.get",
                 "bigtable.backups.list",
                 "bigtable.backups.delete",
                 "bigtable.backups.update",
                 "bigtable.instances.get" ]
}

