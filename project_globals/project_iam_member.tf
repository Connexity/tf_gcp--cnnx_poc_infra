variable "gcp_project" {}

resource "google_project_iam_member" "SA_awx-sa--cnnx-infra-admin--compute_osAdminLogin" {
  member = "serviceAccount:awx-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/compute.osAdminLogin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_awx-sa--cnnx-infra-admin--osconfig_vulnerabilityReportViewer" {
  member = "serviceAccount:awx-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/osconfig.vulnerabilityReportViewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_awx-sa--cnnx-infra-admin--artifactRegistryReader" {
  member = "serviceAccount:awx-sa@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/artifactregistry.reader"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_k8s-sa--cnnx-infra-admin--artifactRegistryReader" {
  member = "serviceAccount:k8s-sa@cnnx-stage-k8s.iam.gserviceaccount.com"
  role = "roles/artifactregistry.reader"
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

resource "google_project_iam_member" "SA_gce-sa--cnnx-poc-infra--iam_serviceAccountUser" {
  member = "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountUser"
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

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--storage_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/storage.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--artifactregistry_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/artifactregistry.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--pubsub_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/pubsub.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--bigtable_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/bigtable.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--dataproc_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/dataproc.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--logging_configWriter" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.configWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--iam_roleAdmin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.roleAdmin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--iam_serviceAccountUser" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-poc-infra--aiplatform_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/aiplatform.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_gce_api--cnnx-poc-infra--compute_instanceAdmin_v1" {
  member = "serviceAccount:service-832312746254@compute-system.iam.gserviceaccount.com"
  role = "roles/compute.instanceAdmin.v1"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_dataproc--cnnx-poc-infra--dataproc_worker" {
  member = "serviceAccount:dataproc@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/dataproc.worker"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_dataproc--cnnx-poc-infra--compute_networkUser" {
  member = "serviceAccount:dataproc@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/compute.networkUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--cloudmigration_inframanager" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/cloudmigration.inframanager"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--cloudmigration_storageaccess" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/cloudmigration.storageaccess"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--iam_serviceAccountUser" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--logging_logWriter" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.logWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--monitoring_metricWriter" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.metricWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--monitoring_viewer" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.viewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-manager--cnnx-poc-infra--iam_serviceAccountTokenCreator" {
  member = "serviceAccount:migration-manager@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountTokenCreator"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-cloud-extension--cnnx-poc-infra--cloudmigration_storageaccess" {
  member = "serviceAccount:migration-cloud-extension@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/cloudmigration.storageaccess"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-cloud-extension--cnnx-poc-infra--monitoring_metricWriter" {
  member = "serviceAccount:migration-cloud-extension@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.metricWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_migration-cloud-extension--cnnx-poc-infra--logging_logWriter" {
  member = "serviceAccount:migration-cloud-extension@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.logWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_vuln-patching-notifications--cnnx-poc-infra--osconfig_vulnerabilityReportViewer" {
  member = "serviceAccount:vuln-patching-notifications@cnnx-infra-admin.iam.gserviceaccount.com"
  role = "roles/osconfig.vulnerabilityReportViewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--compute_networkUser" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/compute.networkUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--dataproc_worker" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/dataproc.worker"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--logging_logWriter" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.logWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--monitoring_metricWriter" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.metricWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--monitoring_viewer" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.viewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--compute_osLogin" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/compute.osLogin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--compute_viewer" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/compute.viewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--dataproc_editor" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/dataproc.editor"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_fasttrack-hdp--cnnx-poc-infra--iap_admin" {
  member = "serviceAccount:fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iap.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_dataproc-service-account--cnnx-poc-infra--compute_networkUser" {
  member = "serviceAccount:service-832312746254@dataproc-accounts.iam.gserviceaccount.com"
  role = "roles/compute.networkUser"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_dataproc-service-account--cnnx-poc-infra--monitoring_viewer" {
  member = "serviceAccount:service-832312746254@dataproc-accounts.iam.gserviceaccount.com"
  role = "roles/dataproc.worker"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_terraform--cnnx-pos-infra--secretmanager_admin" {
  member = "serviceAccount:terraform@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/secretmanager.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "GRP_cnnx-syseng--connexity--bigtable_admin" {
  member = "group:cnnx-syseng@skimlinks.co.uk"
  role = "roles/bigtable.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "GRP_cnnx-syseng--connexity--bigtable_user" {
  member = "group:cnnx-syseng@skimlinks.co.uk"
  role = "roles/bigtable.user"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_firebase-adminsdk-r1mep--cnnx-poc-infra--firebase_sdkAdminServiceAgent" {
  member = "serviceAccount:firebase-adminsdk-r1mep@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/firebase.sdkAdminServiceAgent"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_firebase-adminsdk-r1mep--cnnx-poc-infra--iam_serviceAccountTokenCreator" {
  member = "serviceAccount:firebase-adminsdk-r1mep@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/iam.serviceAccountTokenCreator"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_firebase-service-account--firebase-sa-management--firebase_managementServiceAgent" {
  member = "serviceAccount:firebase-service-account@firebase-sa-management.iam.gserviceaccount.com"
  role = "roles/firebase.managementServiceAgent"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_ncftp-stage--cnnx-poc-infra--logging_logWriter" {
  member = "serviceAccount:ncftp-stage@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.logWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_ncftp-stage--cnnx-poc-infra--monitoring_metricWriter" {
  member = "serviceAccount:ncftp-stage@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.metricWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_ncftp-stage--cnnx-poc-infra--monitoring_viewer" {
  member = "serviceAccount:ncftp-stage@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.viewer"
  project = "${var.gcp_project}"
}


resource "google_project_iam_member" "SA_rt-backup--cnnx-poc-infra--logging_logWriter" {
  member = "serviceAccount:rt-backup@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/logging.logWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_rt-backup--cnnx-poc-infra--monitoring_metricWriter" {
  member = "serviceAccount:rt-backup@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.metricWriter"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_rt-backup--cnnx-poc-infra--monitoring_viewer" {
  member = "serviceAccount:rt-backup@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/monitoring.viewer"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_rt-backup--cnnx-poc-infra--compute.viewer" {
  member = "serviceAccount:rt-backup@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/compute.viewer"
  project = "${var.gcp_project}"
}
