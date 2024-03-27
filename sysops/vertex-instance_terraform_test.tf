resource "google_workbench_instance" "vertex_ai_workbench_vertex-instance_tearraform_test" {
  name = "vertex-instance-tearraform-test"
  location = "us-central1-f"
  gce_setup {
    machine_type = "n1-standard-1"
    disable_public_ip = true
    service_accounts {
      email = "vertex-workbench@cnnx-poc-infra.iam.gserviceaccount.com"
    }
    boot_disk {
      disk_size_gb = 100
      disk_type = "PD_STANDARD"
    }
    network_interfaces {
      network = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
      subnet = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-vertexaiworkbench-1"
    }
  }
  labels = {
    app = "de-v2-dashboard" 
    owner = "platform"
  }
}

resource "google_service_account" "SA_vertex-workbench" {
  account_id   = "vertex-workbench"
  description  = "vertex-workbench SA"
  disabled     = "false"
  display_name = "vertex-workbench"
}

resource "google_project_iam_member" "SA_vertex-workbench--cnnx-poc-infra--notebooks_admin" {
  member = "serviceAccount:vertex-workbench@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/notebooks.admin"
  project = "${var.gcp_project}"
}

resource "google_project_iam_member" "SA_vertex-workbench--cnnx-poc-infra--aiplatform_serviceAgent" {
  member = "serviceAccount:vertex-workbench@cnnx-poc-infra.iam.gserviceaccount.com"
  role = "roles/aiplatform.serviceAgent"
  project = "${var.gcp_project}"
}

resource "google_service_account_iam_binding" "SA_vertex-workbench--iam_serviceAccountUser--iam_binding" {
  service_account_id = google_service_account.SA_vertex-workbench.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:vertex-workbench@cnnx-poc-infra.iam.gserviceaccount.com"
  ]
}
