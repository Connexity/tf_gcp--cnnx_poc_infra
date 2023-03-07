resource "google_compute_instance" "instance_logdumppoc001" {
  name = "logdumppoc001"
  machine_type = "e2-micro"
  project = "${var.gcp_project}"
  zone = "us-central1-f"

  tags = [
    "allow-onprem",
    "allow-gce-usc1-stage",
    "allow-gce-lb"
  ]

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "marketplace"
        app = "logdump"
      }
    }
  }

  labels = {
    owner = "marketplace"
    app = "logdump"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
}

resource "google_compute_instance" "instance_logdumppoc001-eu" {
  name = "logdumppoc001"
  machine_type = "e2-micro"
  project = "${var.gcp_project}"
  zone = "europe-west1-b"

  tags = [
    "allow-onprem",
    "allow-gce-euw1-stage",
    "allow-gce-lb"
  ]

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "marketplace"
        app = "logdump"
      }
    }
  }

  labels = {
    owner = "marketplace"
    app = "logdump"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/europe-west1/subnetworks/cnnx-euw1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
}
