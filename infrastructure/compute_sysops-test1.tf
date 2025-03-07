resource "google_compute_instance" "Instance_backupteststage001-instance" {
  project = "${var.gcp_project}"
  name = "backupteststage001"
  labels = {
    owner = "sysops"
    app = "sysops-test"
  }
  machine_type = "n4-standard-2"
  tags = ["allow-onprem", "allow-gce-usc1-stage"]
  zone = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2204-jammy-v20250112"
      size = 50
      labels = {
        owner = "sysops"
        app = "test"
      }
    }
    auto_delete = "true"
    device_name = "backupteststage001"
    mode        = "READ_WRITE"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  metadata = {
    env            = "staging"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
