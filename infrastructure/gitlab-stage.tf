resource "google_compute_instance" "instance_gitlab-stage" {
  name = "gitlab-stage001"
  machine_type = "e2-standard-4"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-infra", "allow-onprem"]
  project = "${var.gcp_project}"

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  can_ip_forward      = "false"
  deletion_protection = "true"
  enable_display      = "false"

  boot_disk {
    initialize_params {
      size        = "100"
      image      = "cnnx-infra-osimages/cnnx-ubuntu-2204-jammy-v20240126"
    }
    auto_delete = "true"
    device_name = "gitlab-stage001"
    mode        = "READ_WRITE"
  }
    
  labels = {
    app   = "gitlab"
    owner = "syseng"
  }

  metadata = {
    env                = "staging"
    startup-script-url = "http://gitlab.shopzilla.com/ansible/awx-bootstrap-script/-/raw/master/awxprovision.py"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  
}

