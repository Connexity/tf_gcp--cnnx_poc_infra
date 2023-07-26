resource "google_compute_instance" "awxtest-stage-001" {
  name = "awxteststage001"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]

  boot_disk {
    initialize_params {
      size        = "50"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2004-focal-v20210413"
    }
  }

  labels = {
    app   = "awxtest"
    owner = "syseng"
  }

  metadata = {
    env                = "staging"
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

resource "google_compute_instance" "awxtest-stage-002" {
  name = "awxteststage002"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]

  boot_disk {
    initialize_params {
      size        = "50"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2004-focal-v20230715"
    }
  }

  labels = {
    app   = "awxtest"
    owner = "syseng"
  }

  metadata = {
    env                = "staging"
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
