resource "google_compute_instance" "test-eu-stage-001" {
  name = "testeustage001"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags = ["allow-gce-euw1-stage", "allow-onprem"]

  boot_disk {
    initialize_params {
      size        = "50"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2004-focal-v20210413"
    }
  }

  labels = {
    app   = "testing"
    owner = "syseng"
  }

  metadata = {
    env                = "staging"
    startup-script-url = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  network_interface {
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/europe-west1/subnetworks/cnnx-euw1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  
}

