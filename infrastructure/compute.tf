resource "google_compute_instance" "Instance_os-management-test-instances" {
  count = 0

  boot_disk {
    initialize_params {
      size = 50
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "sysops"
        app = "osmanagementtest"
      }
    }
    auto_delete = "true"
    device_name = "${format("os-management-test%03s", count.index+1)}"
    mode        = "READ_WRITE"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    app   = "osmanagementtest"
    owner = "sysops"
  }

  machine_type = "e2-micro"

  metadata = {
    env            = "stage"
  }

  name = "${format("os-management-test%03s", count.index+1)}"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  project = "${var.gcp_project}"

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  tags = ["allow-onprem", "allow-gce-lb", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
}
