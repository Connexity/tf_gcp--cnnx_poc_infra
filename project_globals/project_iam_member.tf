variable "gcp_project" {}

resource "google_project_iam_member" "SA_awx-sa--cnnx-infra-admin--compute_osAdminLogin" {
  member = "serviceAccount:awx-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/compute.osAdminLogin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_dui-sa--cnnx-infra-admin--compute_osLogin" {
  member = "serviceAccount:dui-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/compute.osLogin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_awx-sa--cnnx-infra-admin--compute_viewer" {
  member = "serviceAccount:awx-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/compute.viewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_awx-sa--cnnx-infra-admin--iam_serviceAccountUser" {
  member = "serviceAccount:awx-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_dui-sa--cnnx-infra-admin--iam_serviceAccountUser" {
  member = "serviceAccount:dui-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_gce-sa--cnnx-poc-infra--logging_logWriter" {
  member = "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.logWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_gce-sa--cnnx-poc-infra--monitoring_metricWriter" {
  member = "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.metricWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_gce-sa--cnnx-poc-infra--monitoring_viewer" {
  member = "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.viewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--iam_serviceAccountAdmin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountAdmin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--editor" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/editor"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--resourcemanager_projectIamAdmin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/resourcemanager.projectIamAdmin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--compute_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/compute.admin"
  project = "${var.gcp_project}"
}
