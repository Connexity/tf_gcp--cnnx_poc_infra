resource "google_compute_instance" "ubu2404test-stage" {
  name = "ubu2404teststage001"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]

  boot_disk {
    initialize_params {
      size        = "50"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2404-noble-amd64-v20240516"
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
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
