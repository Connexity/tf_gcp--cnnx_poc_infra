resource "google_workbench_instance" "vertex_ai_workbench_vertex-instance_tearraform_test" {
  name = "projects/cnnx-poc-infra/locations/us-central1-f/instances/vertex-instance_tearraform_test"
  location = "us-central1-f"
  gce_setup {
    machine_type = "n1-standard-1"
    shielded_instance_config {
      enable_secure_boot = true
      enable_vtpm = true
      enable_integrity_monitoring = true
    }
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
      subnet = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    }
  }
  labels = {
    app = "de-v2-dashboard" 
    owner = "platform"
  }
  instance_owners = ["vertex-workbench@cnnx-poc-infra.iam.gserviceaccount.com"]
}
