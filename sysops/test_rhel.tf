resource "google_compute_instance" "Instance_rhel7-test-tf-instance" {
  project = "${var.gcp_project}"
  name = "rhel7-test-tf"
  labels = {
    owner = "sysops"
    app = "rhel7-test-tf"
  }
  machine_type = "n4-standard-2"
  tags = ["allow-onprem", "allow-gce-usc1-stage"]
  zone = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-rhel-7-9-v20250220"
      size = 400
      provisioned_iops = 15000
      provisioned_throughput = 515
      labels = {
        owner = "sysops"
        app = "rhel7-test-tf"
      }
    }
    auto_delete = "true"
    device_name = "rhel7-test-tf"
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
