resource "google_compute_instance" "Instance_schedule-test01" {
  boot_disk {
    auto_delete = "true"
    device_name = "schedule-test01"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-poc-infra/zones/us-central1-a/disks/schedule-test01"
  }

  can_ip_forward = "false"

  confidential_instance_config {
    enable_confidential_compute = "false"
  }

  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    env   = "staging"
    owner = "syseng"
  }

  machine_type = "e2-micro"

  name = "schedule-test01"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    network_ip         = ""
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

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  tags = ["allow-onprem", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
}

